% K-peak finding algorithm [Final phase]

clc;
clear all;
close all;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/ConvertPlot4Publication/WSI_Scripts/UPS/';
Path3 = 'UPS_0003';

load('/Users/manojgulati/Documents/Algo_Testing_Data/ConvertPlot4Publication/WSI_Scripts/f_axis_RFI.mat');
f_axis_new = f_axis(501:1000)'/1000000;

load(strcat(Path1,Path3,'_RFI','.mat'));

%
[pks,locs] = findpeaks(sum_buffer(500:1000),'SORTSTR','descend');

% Enable Plot Function here
plot(f_axis_new,sum_buffer(501:1000));
xlim([-0.01 1]);
hold on;
plot(f_axis_new(locs(1:10)),pks(1:10),'r*');
xlim([-0.01 1]);
xlabel('Frequency (in MHz)');
ylabel('Amplitude (in dB)');
grid on;
legend('UPS');

% matrix = [];
% matrix(:,:) = [f_axis_new(locs(1:20)) pks(1:20)];

% save(strcat(Path2, Path4, Path3,'_Kpeak_',int2str(index),'.mat'),'matrix');
% saveas(gcf,strcat(Path1,Path2,Path4,Path3,'_visualize_Test_',int2str(index),'.png'));

ConvertPlot4Publication(strcat(Path1,Path3,'_KPeak'),'fontsize', 8.5, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',1,'pdf','off','eps','off','psfrag','off','fig','off');



