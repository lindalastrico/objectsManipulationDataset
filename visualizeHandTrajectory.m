function [] = visualizeHandTrajectory(subj, trial, data)
% visualizeHandTrajectory --- given the motion capture data structure amd
% the desired participant and trial, it produces a 3D plot of the
% trajectories of the markers on the hand
%              Input:
%                   - subj: subject number, int between 1 and 15
%                   - trial: trial number, int between 1 and 80
%                   - data: motion capture data structure, created with 
%                           loadmocap function
%              Output:
%                   [] 
% Example of use:
% visualizeHandTrajectory(3,14,mocap_data);
% It produces a figure with the 3D trajectories of the hand markers
% performed by participant 3 in trial 14
% Missing values (due to markers not visible) are not interpolated

tmp=data{subj,trial};

% See Figure 4 of the paper for a more clear representation of the markers
% position

% Marker 1 - index metacarpophalangeal joint
% Marker 2 - little finger metacarpophalangeal joint
% Marker 3 - diaphysis of the third metacarpal
% Marker 4 - on the smartwatch dial in correspondance of the radial styloid
% Marker 5 - on the smartwatch dial in correspondance of the ulnar styloid
% Marker 6 - right watch strap
% Marker 15 - left watch strap

figure; hold on
plot3(tmp.mkr1_x,-tmp.mkr1_y,-tmp.mkr1_z,'r','LineWidth',2); 
scatter3(tmp.mkr1_x(1),-tmp.mkr1_y(1),-tmp.mkr1_z(1),'*r','HandleVisibility','off','LineWidth',1); % Marker 1 - index metacarpophalangeal joint
plot3(tmp.mkr2_x,-tmp.mkr2_y,-tmp.mkr2_z,'b','LineWidth',2); 
scatter3(tmp.mkr2_x(1),-tmp.mkr2_y(1),-tmp.mkr2_z(1),'*b','HandleVisibility','off','LineWidth',1); % Marker 2 - little finger metacarpophalangeal joint
plot3(tmp.mkr3_x,-tmp.mkr3_y,-tmp.mkr3_z,'k','LineWidth',2); 
scatter3(tmp.mkr3_x(1),-tmp.mkr3_y(1),-tmp.mkr3_z(1),'*k','HandleVisibility','off','LineWidth',1); % Marker 3 - diaphysis of the third metacarpal
plot3(tmp.mkr4_x,-tmp.mkr4_y,-tmp.mkr4_z,'g','LineWidth',2); 
scatter3(tmp.mkr4_x(1),-tmp.mkr4_y(1),-tmp.mkr4_z(1),'*g','HandleVisibility','off','LineWidth',1); % Marker 4 - on the smartwatch dial in correspondance of the radial styloid
plot3(tmp.mkr5_x,-tmp.mkr5_y,-tmp.mkr5_z,'c','LineWidth',2); 
scatter3(tmp.mkr5_x(1),-tmp.mkr5_y(1),-tmp.mkr5_z(1),'*c','HandleVisibility','off','LineWidth',1); % Marker 5 - on the smartwatch dial in correspondance of the ulnar styloid
plot3(tmp.mkr6_x,-tmp.mkr6_y,-tmp.mkr6_z,'m','LineWidth',2); 
scatter3(tmp.mkr6_x(1),-tmp.mkr6_y(1),-tmp.mkr6_z(1),'*m','HandleVisibility','off','LineWidth',1); % Marker 6 - right watch strap
plot3(tmp.mkr15_x,-tmp.mkr15_y,-tmp.mkr15_z,'y','LineWidth',2); 
scatter3(tmp.mkr15_x(1),-tmp.mkr15_y(1),-tmp.mkr15_z(1),'*y','HandleVisibility','off','LineWidth',1); % Marker 15 - left watch strap
legend("mkr1","mkr2","mkr3","mkr4","mkr5","mkr6","mkr15")
title(strcat("3D Hand Trajectory - Subject ", num2str(subj), " Trial ", num2str(trial)));
xlabel("x");
ylabel("z");
zlabel("y");
grid on

end