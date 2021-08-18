function [] = animatedPlot(folder, videoName, data, timeCamera, pov)

% animatedPlot --- Creates a plot showing the video from the specified
% camera and the hand markers during the movement
%              Input:
%                   - folder: path of the folder where the video is stored
%                   - videoName: file name of the video to consider
%                   - motion capture data for the participant and trial
%                   corresponding to the video
%                   - yarp timestamp of the camera (is returned by
%                   the function createVideo)                                
%                   - pov: integer specifying the used sensor (0
%                   robot camera, 1 lateral high resolution camera, 2 back
%                   high resolution camera)
%              Output:
%                   [] 
%
% Previous steps required: Create a video from the images recorded with the
% back camera (cam_2) of Participant 13 performing Trial 62
% inputDir = 'C:\Users\...\objectsManipulationDataset\data\' ;
% outputDir='C:\Users\...\Videos\manipulationVideos\cam2\'   
% timestampCamera2 = createVideo(13, 62, 2, inputDir, outputDir);
%
% Example of use:
% animatedPlot(outputDir, "P013_Trial_062.avi", mocap_data{13,62}, timestampCamera2, 2);

cd(folder)
vid=VideoReader(videoName);

figure
sgtitle(extractBefore(videoName,".avi"), 'Interpreter', 'none');
%downsampling Mocap timestamp (~100 Hz) to the camera one (~30 Hz if high
%res, ~22 Hz if robot's)
timeMocap = interp1(data.timestamp,data.timestamp,timeCamera);
timeMocap(1)=timeCamera(1);
idx_Mocap=[];
for i=1:size(timeMocap,1)
    [c index] = min(abs(data.timestamp-timeMocap(i))); %finding the corresponding timestamps between camera's and Mocap's
    idx_Mocap=[idx_Mocap;index];
end

%Considering markers on the hand (#1-#5)
h1_x = double(data.mkr1_x(idx_Mocap))./1000;
h1_y = double(data.mkr1_y(idx_Mocap))./1000;
h1_z = double(data.mkr1_z(idx_Mocap))./1000;
h2_x = double(data.mkr2_x(idx_Mocap))./1000;
h2_y = double(data.mkr2_y(idx_Mocap))./1000;
h2_z = double(data.mkr2_z(idx_Mocap))./1000;
h3_x = double(data.mkr3_x(idx_Mocap))./1000;
h3_y = double(data.mkr3_y(idx_Mocap))./1000;
h3_z = double(data.mkr3_z(idx_Mocap))./1000;
h4_x = double(data.mkr4_x(idx_Mocap))./1000;
h4_y = double(data.mkr4_y(idx_Mocap))./1000;
h4_z = double(data.mkr4_z(idx_Mocap))./1000;
h5_x = double(data.mkr5_x(idx_Mocap))./1000;
h5_y = double(data.mkr5_y(idx_Mocap))./1000;
h5_z = double(data.mkr5_z(idx_Mocap))./1000;

% Adjust the point of view of the skeleton plot with the video
az = 0;
el = 0;

% calculating the STEP that should pass between two frames 
% (~30fps -> 3 frames every 0.1 sec)
deltaT = median(diff(timeCamera)); %median step for camera's data

%changing point of view according to the camera position
switch(pov)
    case 0
        az = -10;  
        el = -25;   
    case 1
        az = 165;
        el = 90;
    case 2
        az = -165;
        el = 90;
end

%calculating max and min markers' positions to adapt the axes limits
max_x=max([h1_x;h2_x;h3_x;h4_x;h5_x]);
min_x=min([h1_x;h2_x;h3_x;h4_x;h5_x]);
max_y=max([h1_y;h2_y;h3_y;h4_y;h5_y]);
min_y=min([h1_y;h2_y;h3_y;h4_y;h5_y]);
max_z=max([h1_z;h2_z;h3_z;h4_z;h5_z]);
min_z=min([h1_z;h2_z;h3_z;h4_z;h5_z]);

colors=[0 0.4470 0.7410;0.8500 0.3250 0.0980;0.9290 0.6940 0.1250;...
    0.4940 0.1840 0.5560;0.4660 0.6740 0.1880];

frame = 1;
i=1;
while(hasFrame(vid))    
    % video
    subplot(1,2,1);
    image(readFrame(vid));
    title(['Frame: ', num2str(frame)]);
    
    % hand trajectory
    h2=subplot(1,2,2); hold on %-x -y -z
    if(i==1)
        ylim([ min_y max_y]);
        xlim([ min_x max_x]);
        zlim([ min_z max_z]);
        xlabel("x");
        ylabel("z");
        zlabel("y");
%         % legend commented to not slow down the animated plot
        %         legend("mkr1","mkr2","mkr3","mkr4","mkr5",'location','best');
        grid on
        view(az,el);
    end
    title(['Frame: ',num2str(i)]);
    scatter3(h1_x(i), h1_y(i), h1_z(i), 'o', 'filled','markerFaceColor',colors(1,:),'markerEdgeColor',colors(1,:));
    scatter3(h2_x(i), h2_y(i), h2_z(i), 'o', 'filled','markerFaceColor',colors(2,:),'markerEdgeColor',colors(2,:));
    scatter3(h3_x(i), h3_y(i), h3_z(i), 'o', 'filled','markerFaceColor',colors(3,:),'markerEdgeColor',colors(3,:));
%     % commented to not slow down the animated plot
    %     scatter3(h4_x(i), h4_y(i), h4_z(i), 'o', 'filled','markerFaceColor',colors(4,:),'markerEdgeColor',colors(4,:));   
    %     scatter3(h5_x(i), h5_y(i), h5_z(i), 'o', 'filled','markerFaceColor',colors(5,:),'markerEdgeColor',colors(5,:));
    
%     % pause between frames to simulate the fps rate
    pause(deltaT);
%     % comment the following line if the whole trajectory is desired
    cla(h2); %change

    if(i>size(h1_x))
        break;
    end
   
    i=i+1;
    frame=frame+1;
    
end

%     % comment the following line to leave the plot open
close %change

end