function [] = createVideo(participant,trial,sensor, f, inputDir, outputDir)

% finding the subfolder corresponding to the inserted participant
listParticipants=struct2cell(dir(inputDir));
idx=find(contains(listParticipants(1,:),string(participant)),1,'first');
folder_P=string(listParticipants(1,idx));
tmp=strcat(inputDir,folder_P,"\");
cd(tmp);
% finding the subfolder corresponding to the inserted trial
listTrials=struct2cell(dir(tmp));
idx=find(contains(listTrials(1,:),string(trial)),1,'first');
folder_trial=string(listTrials(1,idx));
workingDir=strcat(tmp,folder_trial,"\");
cd(workingDir);

imageNames = dir(fullfile(workingDir,'*.jpg')); 
imageNames = {imageNames.name}';

outputVideo = VideoWriter(fullfile(outputDir,strcat(folder_P, folder_trial,'.avi'))); 

outputVideo.FrameRate = 20; %change
open(outputVideo)

for ii = 1:length(imageNames)      
    imname=char(imageNames(ii));    %use this if the file names don't start from 1 (eg 0000583.jpg)
    %imname = sprintf('__%06d.png' ,ii);  %%use this if the file names  start from 1 (eg 0000001.jpg)
    img = imread(fullfile(workingDir,imname));
    writeVideo(outputVideo,img)
end

close(outputVideo)

end
