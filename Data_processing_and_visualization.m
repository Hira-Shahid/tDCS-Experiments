clear all;
load locs.mat;
% files = dir('*.mat');
% 
% for i = 1:length(files)
%    eval(['load ' files(i).name ' -mat']);
% end

myFolder = 'D:\Hira\tDCS\Experiments\Analysis\Total\New folder (4)'; 
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, '*.mat');
matFiles = dir(filePattern);
matData = {};
md = {};
for k = 1:length(matFiles)
  baseFileName = matFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  matData{k} = load(fullFileName);
  md{k} = cell2mat(struct2cell (matData{k}));
end

fs = 500;
windowLength = fs*4; % for 4 sec window
noverlap = windowLength/2; % for 50% overlap
nfft = windowLength;

a = 1;
b = 1;

for i = 1:(length (matFiles)-1);
    
for j=1:31;
    name = cell2mat(md(i));
    [p(j,:),f] = pwelch(name(j,:),windowLength,noverlap,nfft,fs);
    meanallchan(:,j) = mean(p(j,:));
    relativepower(:,j) = p(j,:)/meanallchan(:,j);
    rp_delta (:,j) = mean(relativepower (1:17,j));
    rp_theta (:,j) = mean(relativepower (18:33,j));
    rp_alpha (:,j) = mean(relativepower (34:49,j));
    rp_beta (:,j) = mean(relativepower (50:121,j));
end

power(:,:,a) = (p);
means(:,:,a) = (meanallchan);
relative_power(:,:,a) = (relativepower);
rp_del (:,:,a) = (rp_delta);
rp_the (:,:,a) = (rp_theta);
rp_alp (:,:,a) = (rp_alpha);
rp_be (:,:,a) = (rp_beta);
a = a+1;

if (rem(i, 4) == 0)
 power_pre_ec(:,:,b) = power (:,:,1);
 power_post_ec(:,:,b) = power (:,:,2);
 power_pre_eo(:,:,b) = power (:,:,3);
 power_post_eo(:,:,b) = power (:,:,4);
 meanz_pre_ec(:,:,b) = means(:,:,1);
 meanz_post_ec(:,:,b) = means(:,:,2);
 meanz_pre_eo(:,:,b) = means(:,:,3);
 meanz_post_eo(:,:,b) = means(:,:,4);
 relative_power_pre_ec(:,:,b) = relative_power(:,:,1) ;
 relative_power_post_ec(:,:,b) = relative_power(:,:,2) ;
 relative_power_pre_eo(:,:,b) = relative_power(:,:,3) ;
 relative_power_post_ec(:,:,b) = relative_power(:,:,4) ;
 relative_power_delta_pre_ec(:,:,b) = rp_del(:,:,1) ;
 relative_power_delta_post_ec(:,:,b) = rp_del(:,:,2) ;
 relative_power_delta_pre_eo(:,:,b) = rp_del(:,:,3) ;
 relative_power_delta_post_eo(:,:,b) = rp_del(:,:,4) ;
 relative_power_theta_pre_ec(:,:,b) = rp_the(:,:,1);
 relative_power_theta_post_ec(:,:,b) = rp_the(:,:,2);
 relative_power_theta_pre_eo(:,:,b) = rp_the(:,:,3);
 relative_power_theta_post_eo(:,:,b) = rp_the(:,:,4);
 relative_power_alpha_pre_ec(:,:,b) = rp_alp(:,:,1);
 relative_power_alpha_post_ec(:,:,b) = rp_alp(:,:,2);
 relative_power_alpha_pre_eo(:,:,b) = rp_alp(:,:,3);
 relative_power_alpha_post_eo(:,:,b) = rp_alp(:,:,4);
 relative_power_beta_pre_ec(:,:,b) = rp_be(:,:,1);
 relative_power_beta_post_ec(:,:,b) = rp_be(:,:,2);
 relative_power_beta_pre_eo(:,:,b) = rp_be(:,:,3);
 relative_power_beta_post_eo(:,:,b) = rp_be(:,:,4);
 std_chantopo({relative_power_delta_pre_ec(1,:,b) relative_power_delta_post_ec(1,:,b) relative_power_theta_pre_ec(1,:,b) relative_power_theta_post_ec(1,:,b) relative_power_alpha_pre_ec(1,:,b) relative_power_alpha_post_ec(1,:,b) relative_power_beta_pre_ec(1,:,b) relative_power_beta_post_ec(1,:,b)},'chanlocs', locs)
 std_chantopo({relative_power_delta_pre_eo(1,:,b) relative_power_delta_post_eo(1,:,b) relative_power_theta_pre_eo(1,:,b) relative_power_theta_post_eo(1,:,b) relative_power_alpha_pre_eo(1,:,b) relative_power_alpha_post_eo(1,:,b) relative_power_beta_pre_eo(1,:,b) relative_power_beta_post_eo(1,:,b)},'chanlocs', locs)
 
 a = 1;
 b = b+1;
end 
end 