% K-peak finding algorithm [Testing phase]

clc;
clear all;
close all;

Path1 = '/Users/manojgulati/Databin/';
Path2 = 'Plug [24-05-2015]/';
Path3 = 'PRT1_';
Path4 = 'KPeak_Features/';
No_of_traces = 100;
index=1;
while(index<No_of_traces+1)
load(strcat(Path1,Path2,Path3,'FFT',int2str(index),'.mat'));

%
[pks,locs] = findpeaks(matrix(:,3),'SORTSTR','descend');

%
% plot(matrix(:,1),matrix(:,3));
% xlim([0 .1]);
% hold on;
% plot(matrix(locs(1:10),1),pks(1:10),'r*');
% xlim([0 .1]);
matrix = [];
matrix(:,:) = [locs(1:10) pks(1:10)];
% matrix(:,2) = pks(1:10);

save(strcat(Path1, Path2, Path4, Path3,int2str(index),'.mat'),'matrix');

index=index+1;
end