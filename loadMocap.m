function [data] = loadMocap(folder)
% loadMocap --- loads the raw motion capture data and return and saves
%                 a data structure.
%              Input:
%                   - folder: path of the folder in which csv files
%                     are stored.
%              Output:
%                   [data] = structure containing the MoCap data of the
%                   whole experiment. Each row is a subject, each column a
%                   trial.
%
% Example of use:
% folder = '../mocap/';
% mocap_data = loadMocap(folder);
%


% list of folders for every participant
d=dir(folder);
d = d(~ismember({d(:).name},{'.','..'}));
% Each marker has 3 columns (one per coordinate) and a 4th one (the flag
% column) reporting a 0 if the data is available, 1 if the marker was not
% visible
flag_columns=[6:4:62];

for k=1:length(d)
    
    P_folder=strcat(d(1).folder,"\",d(k).name);
    cd(P_folder);
    % loading the experiment files for the participant k
    mkr_files=dir('*.csv');
    for i=1:length(mkr_files)
        tmp = readmatrix(mkr_files(i).name);    %reading trial data
        % substituting missing data with NaNs
        for j=1:length(flag_columns)
            tmp(find(tmp(:,flag_columns(j))==1),flag_columns(j)-3:flag_columns(j)-1) = NaN;
        end
        v_names={'ID','timestamp_yarp','mkr1_x','mkr1_y','mkr1_z','mkr1_visibility',...
            'mkr2_x','mkr2_y','mkr2_z','mkr2_visibility',...
            'mkr3_x','mkr3_y','mkr3_z','mkr3_visibility',...
            'mkr4_x','mkr4_y','mkr4_z','mkr4_visibility',...
            'mkr5_x','mkr5_y','mkr5_z','mkr5_visibility',...
            'mkr6_x','mkr6_y','mkr6_z','mkr6_visibility',...
            'mkr7_x','mkr7_y','mkr7_z','mkr7_visibility',...
            'mkr8_x','mkr8_y','mkr8_z','mkr8_visibility',...
            'mkr9_x','mkr9_y','mkr9_z','mkr9_visibility',...
            'mkr10_x','mkr10_y','mkr10_z','mkr10_visibility',...
            'mkr11_x','mkr11_y','mkr11_z','mkr11_visibility',...
            'mkr12_x','mkr12_y','mkr12_z','mkr12_visibility',...
            'mkr13_x','mkr13_y','mkr13_z','mkr13_visibility',...
            'mkr14_x','mkr14_y','mkr14_z','mkr14_visibility',...
            'mkr15_x','mkr15_y','mkr15_z','mkr15_visibility',...
            };
        data{k,i}=array2table(tmp,'VariableNames',v_names);
    end
    
end
cd ..\..
mocap_data=data;
savefile='mocap.mat';
save(savefile,'mocap_data');
end


%     P_folder=strcat(d(1).folder,"\",d(k).name);
%     cd(P_folder);
%     % loading the experiment files for the participant k
%     ts_files=dir('*_ts*.txt');
%     te_files=dir('*_te*.txt');
%     mkr_files=dir('*_mkr*.txt');
%     for i=1:length(ts_files)
%         ts = readmatrix(ts_files(i).name);
%         te = readmatrix(te_files(i).name);
%         mkr = readmatrix(mkr_files(i).name);
%         % adding the timestamp information to the matrix
%         data{k,i} = [mkr(:,1), linspace(ts,te,length(mkr))', mkr(:,2:end)];
%     end