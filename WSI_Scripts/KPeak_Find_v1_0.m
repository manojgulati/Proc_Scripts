% K-peak finding algorithm [Testing phase]

clc;
clear all;
close all;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/ConvertPlot4Publication/WSI_Scripts/Data4Detection/EXTRACTED_FFT/';
Path3 = 'INDUCTION';
Path4 = 'KPeak_Features/';
Path2 = '/Users/manojgulati/Documents/Algo_Testing_Data/ConvertPlot4Publication/WSI_Scripts/Data4Detection/';

load('/Users/manojgulati/Documents/Algo_Testing_Data/ConvertPlot4Publication/WSI_Scripts/f_axis_RFI.mat');
f_axis_new = f_axis(501:1000)';

No_of_traces = 1999;
index=1;
while(index<No_of_traces+1)
load(strcat(Path1,Path3,'_RFI_',int2str(index),'.mat'));

%
[pks,locs] = findpeaks(buffer1(500:1000),'SORTSTR','descend');

% Enable Plot Function here
plot(f_axis_new,buffer1(500:1000));
xlim([-1 10*10^5]);
hold on;
plot(f_axis_new(locs(1:10)),pks(1:10),'r*');
xlim([-1 10*10^5]);

matrix = [];
matrix(:,:) = [f_axis_new(locs(1:20)) pks(1:20)];

% save(strcat(Path2, Path4, Path3,'_Kpeak_',int2str(index),'.mat'),'matrix');
% saveas(gcf,strcat(Path1,Path2,Path4,Path3,'_visualize_Test_',int2str(index),'.png'));

index=index+1;
end