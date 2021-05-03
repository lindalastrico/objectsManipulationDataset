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
% mocap_data = loadInertial(folder);
%


% list of folders for every participant
d=dir(folder);
d = d(~ismember({d(:).name},{'.','..'}));

for k=1:length(d)
    P_folder=strcat(d(1).folder,"\",d(k).name);
    cd(P_folder);
    % loading the experiment files for the participant k
    mkr_files=dir('*.json');
    for i=1:length(mkr_files)
        data{k,i} = jsondecode(fileread(mkr_files(i).name));        
    end    
end
cd ..\..
savefile='inertial.mat';
save(savefile,'data');
end


