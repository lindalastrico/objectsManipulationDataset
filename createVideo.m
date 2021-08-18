function [timestamp] = createVideo(participant,trial,sensor, inputDir, outputDir)

% createVideo --- Creates a .avi video from the images related to the 
%                 specified participant and trial acquired with the 
%                 specified sensor.
%              Input:
%                   - participant: integer specifying the subject number (1
%                   to 15)                                                      
%                   - trial: integer specifying the trial number (1
%                   to 80)  
%                   - sensor: integer specifying the desired sensor (0
%                   robot camera, 1 lateral high resolution camera, 2 back
%                   high resolution camera)
%                   - inputDir: path to folder where the dataset data are saved
%                   - outputDir: path to folder where the video will be
%                   saved
%              Output: 
%                   - timestamp: yarp timestamp of the images
%                   acquisition. It can be used to create an animated plot
%                   of video and marker trajectories with the function
%                   animatedPlot
%                     
%
% Example of use: Creating a video from images recorded with the back camera
% (cam_2) of Participant 1 performing Trial 10
% inputDir = 'C:\Users\...\objectsManipulationDataset\data\' ;
% outputDir = 'C:\Users\...\Videos\manipulationVideos\'   
% timestamp = createVideo(1, 10, 2, inputDir, outputDir);

% finding the subfolder corresponding to the inserted sensor
folder_sensor=strcat('cam_',num2str(sensor),"\");
tmp=strcat(inputDir,folder_sensor);
cd(tmp);
% finding the subfolder corresponding to the inserted participant
listParticipants=struct2cell(dir(tmp));
idx=find(contains(listParticipants(1,:),string(participant)),1,'first');
folder_P=string(listParticipants(1,idx));
tmp=strcat(inputDir,folder_sensor,folder_P,"\");
cd(tmp);
% finding the subfolder corresponding to the inserted trial
listTrials=struct2cell(dir(tmp));
idx=find(contains(listTrials(1,:),string(trial)),1,'first');
folder_trial=string(listTrials(1,idx));
workingDir=strcat(tmp,folder_trial,"\");
cd(workingDir);

% loading the log file with the timestamps of the acquisition
log=importdata("data.txt");
timestamp=log(:,1);
duration=timestamp(end)-timestamp(1);
disp(strcat("Video duration: ",num2str(duration)," seconds"));
% calculating the frame rate for the video
f = median(1./diff(timestamp));
imageNames = dir(fullfile(workingDir,'*.jpg')); 
imageNames = {imageNames.name}';

outputVideo = VideoWriter(fullfile(outputDir,strcat(folder_trial,'.avi'))); 

outputVideo.FrameRate = f; 
open(outputVideo)

for ii = 1:length(imageNames)      
    imname=char(imageNames(ii));    %use this if the file names don't start from 1 (eg 0000583.jpg)
    %imname = sprintf('__%06d.png' ,ii);  %%use this if the file names  start from 1 (eg 0000001.jpg)
    img = imread(fullfile(workingDir,imname));
    writeVideo(outputVideo,img);
end

close(outputVideo)

end
