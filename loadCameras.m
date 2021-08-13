function [timestamp] = loadCameras(rootFolder)
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
        timestamp{i,k}=t(:,1);
        cd ..
    end
end

end



% % %  cd(fullfile(rootFolder,d(i).name))
% % %     d2=dir;
% % %     d2 = d2(~ismember({d2(:).name},{'.','..'}));
% % % %     for k=2:length(d2)
% % % k=1  for participant 1
% % %
% % %         P_folder=strcat(d2(1).folder,"\",d2(k).name);
% % %         cd(P_folder);
% % %         data_dumper = (importdata('data.log'));
% % % %         for j=1:length(data_dumper)
% % % %             boh=split(data_dumper{j});
% % % %             boh{3}=(boh{3}(1:end-4));
% % % %             tmp{j,1}=boh{2};
% % % %             tmp{j,2}=boh{3};
% % % %         end
% % % %         boh=[];
% % % data_dumper=data_dumper(:,2:end);
% % % tmp=num2cell(data_dumper);
% % % for j=1:length(data_dumper)
% % %     tmp{j,2}=sprintf('%08d',(data_dumper(j,2)));
% % %     tmp{j,1}=sprintf('%.6f',(data_dumper(j,1))); for P1
% % % end
% % %         writecell(tmp,'data2.txt','Delimiter','space');
% % %         tmp=[];
% % % %     end
% % % end