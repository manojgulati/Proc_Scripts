% K-peak finding algorithm [Testing phase]

clc;
clear all;
close all;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/';
Path2 = 'CFL';
Path3 = '/FFT/';
Path4 = '/Trial_kNN_Analytics/kpeak_features_CM/';
Path5 = 'CFL5_';
No_of_traces = 1500;
index=1;

while(index<No_of_traces+1)
load(strcat(Path1,Path2,Path3,Path5,'FFT',int2str(index),'.mat'));

% Extract peaks information from CM EMI data.
[pks,locs] = findpeaks(matrix(:,3),'SORTSTR','descend');

% Enable Plot Function here
% figure;
% plot(matrix(:,1),matrix(:,3));
% % xlim([0 .2]);
% hold on;
% plot(matrix(locs(1:10),1),pks(1:10),'r*');
% % xlim([0 .2]);
% ylim([-160 -30]);

matrix = [];
matrix(:,:) = [locs(1:10) pks(1:10)];

save(strcat(Path1, Path4, Path5,int2str(index),'.mat'),'matrix');
% saveas(gcf,strcat(Path1,Path2,Path4,Path3,'_visualize_Test_',int2str(index),'.png'));

index=index+1;
end