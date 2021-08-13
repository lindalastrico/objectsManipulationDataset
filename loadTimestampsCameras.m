function [data] = loadTimestampsCameras(rootFolder)

% loadCameras --- loads the log files of each one of the 3 cameras and
%                 return and saves a data structure.
%              Input:
%                   - folder: path of the folder in which the log files
%                     are stored.
%              Output:
%                   [data] = structure containing the Yarp timestamp of the 
%                   experiment for each subject. Each row is a subject, 
%                   each column a sensor (cam_0 robot camera, cam_1 lateral
%                   camera, cam_2 frontal camera
%
% Example of use:
% folder = '../data/';
% cameras_timestamp = loadCameras(folder);
%
d=dir(rootFolder);
d = d(~ismember({d(:).name},{'.','..'}));

for i=1:3
    cd(fullfile(rootFolder,d(i).name));
    d2=dir;
    d2 = d2(~ismember({d2(:).name},{'.','..'}));
    for k=1:length(d2)
        P_folder=strcat(d2(1).folder,"\",d2(k).name);
        cd(P_folder);
        % loading the experiment files for the participant k
        t=importdata('data.log');
        timestamp{k,i}=t(:,1);
        cd ..
    end
end
v_names={'timestamp_cam0','timestamp_cam1','timestamp_cam2'};
data=array2table(timestamp,'VariableNames',v_names);
end
