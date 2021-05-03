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
% Each marker has 3 columns (one per coordinate) and a 4th one
% reporting a 0 if the data is available, 1 if the marker was not
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
        data{k,i}=tmp;
    end
    
end
cd ..\..
savefile='mocap.mat';
save(savefile,'data');
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