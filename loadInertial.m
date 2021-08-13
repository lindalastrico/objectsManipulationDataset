function [data] = loadInertial(folder)
% loadInertial --- loads the raw inertial data and return and saves
%                 a data structure.
%              Input:
%                   - folder: path of the folder in which json files
%                     are stored.
%              Output:
%                   [data] = structure containing the inertial data of the
%                   whole experiment. Each row is a subject, each column a
%                   trial.
%
% Example of use:
% folder = '../inertial/';
% inertial_data = loadInertial(folder);



% list of folders for every participant
d=dir(folder);
d = d(~ismember({d(:).name},{'.','..'}));

for k=1:length(d)
    P_folder=strcat(d(1).folder,"\",d(k).name);
    cd(P_folder);
    % loading the experiment files for the participant k
    inert_files=dir('*.json');
    for i=1:length(inert_files)
        tmp = jsondecode(fileread(inert_files(i).name));
        t(:,1)=extractfield(tmp,'yarp_time');
        t(:,2)=str2double(extractfield(tmp,'stamp_android')');
        t(:,3)=extractfield(tmp,'stamp_nsecs');  %ros timestamp
        t(:,4)=extractfield(tmp,'stamp_secs');  %ros timestamp
        t(:,5)=extractfield(tmp,'angular_velocity_x');
        t(:,6)=extractfield(tmp,'angular_velocity_y');
        t(:,7)=extractfield(tmp,'angular_velocity_z');
        t(:,8)=extractfield(tmp,'linear_acceleration_x');
        t(:,9)=extractfield(tmp,'linear_acceleration_y');
        t(:,10)=extractfield(tmp,'linear_acceleration_z');
%         data{k,i}=t;
        v_names={'timestamp_yarp','timestamp_android','timestamp_ROS_nsecs','timestamp_ROS_secs',...
            'ang_vel_x','ang_vel_y','ang_vel_z',...
            'lin_acc_x','lin_acc_y','lin_acc_z'...
            };
        data{k,i}=array2table(t,'VariableNames',v_names);
        t=[];
    end
    
end
cd ..\..
inertial_data=data;
savefile='inertial.mat';
save(savefile,'inertial_data');
end


