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
% produced by participant 3 in trial 14

tmp=data{subj,trial};

% See Figure 4 of the paper for a more clear representation of the markers
% position

mkr1=[3,4,5]; % Marker 1 - index metacarpophalangeal joint
mkr2=[7,8,9]; % Marker 2 - little finger metacarpophalangeal joint
mkr3=[11,12,13]; % Marker 3 - diaphysis of the third metacarpal
mkr4=[15,16,17]; % Marker 4 - on the smartwatch dial in correspondance of the radial styloid
mkr5=[19,20,21]; % Marker 5 - on the smartwatch dial in correspondance of the ulnar styloid
mkr6=[23,24,25]; % Marker 6 - right watch strap
mkr15=[59,60,61]; % Marker 15 - left watch strap

figure; hold on
plot3(tmp(:,mkr1(1)),-tmp(:,mkr1(2)),-tmp(:,mkr1(3)),'r','LineWidth',2); 
scatter3(tmp(1,mkr1(1)),-tmp(1,mkr1(2)),-tmp(1,mkr1(3)),'*r','HandleVisibility','off','LineWidth',2); %1
plot3(tmp(:,mkr2(1)),-tmp(:,mkr2(2)),-tmp(:,mkr2(3)),'b','LineWidth',2); 
scatter3(tmp(1,mkr2(1)),-tmp(1,mkr2(2)),-tmp(1,mkr2(3)),'*b','HandleVisibility','off','LineWidth',2); %2
plot3(tmp(:,mkr3(1)),-tmp(:,mkr3(2)),-tmp(:,mkr3(3)),'k','LineWidth',2); 
scatter3(tmp(1,mkr3(1)),-tmp(1,mkr3(2)),-tmp(1,mkr3(3)),'*k','HandleVisibility','off','LineWidth',2); %3
plot3(tmp(:,mkr4(1)),-tmp(:,mkr4(2)),-tmp(:,mkr4(3)),'g','LineWidth',2); 
scatter3(tmp(1,mkr4(1)),-tmp(1,mkr4(2)),-tmp(1,mkr4(3)),'*g','HandleVisibility','off','LineWidth',2); %4
plot3(tmp(:,mkr5(1)),-tmp(:,mkr5(2)),-tmp(:,mkr5(3)),'c','LineWidth',2); 
scatter3(tmp(1,mkr5(1)),-tmp(1,mkr5(2)),-tmp(1,mkr5(3)),'*c','HandleVisibility','off','LineWidth',2); %5
plot3(tmp(:,mkr6(1)),-tmp(:,mkr6(2)),-tmp(:,mkr6(3)),'m','LineWidth',2); 
scatter3(tmp(1,mkr6(1)),-tmp(1,mkr6(2)),-tmp(1,mkr6(3)),'*m','HandleVisibility','off','LineWidth',2); %6
plot3(tmp(:,mkr15(1)),-tmp(:,mkr15(2)),-tmp(:,mkr15(3)),'y','LineWidth',2); 
scatter3(tmp(1,mkr15(1)),-tmp(1,mkr15(2)),-tmp(1,mkr15(3)),'*y','HandleVisibility','off','LineWidth',2); %15
legend("mkr1","mkr2","mkr3","mkr4","mkr5","mkr6","mkr15")
title(strcat("3D Trajectory Subject ", num2str(subj), " Trial ", num2str(trial)));
xlabel("x");
ylabel("z");
zlabel("y");
grid on

end