% % Plotting script for FFT Spectrum
clc;
clear all;

%
AUT_Name = ['LC1'; 'LC2'; 'LC3'; 'LC4';'LC5'];
AUT_Name1 = ['CFL1';'CFL2';'CFL3';'CFL4';'CFL5';'LCD1';'LCD2';'LCD3';'LCD4';'LCD5';'CPU1';'CPU2';'CPU3';'CPU4';'CPU5';];

index=1;

while index<6;
    
% Dump images here
Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/Plots_1/';
Path3 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/Processed_FFT/';
Path2 = 'BGN_';
Path4 = AUT_Name(index,:);
File_Path1 = strcat(Path3,Path2,Path4);
File_Path2 = strcat(Path3,Path4);

BGND(:,:) = importdata(strcat(File_Path1,'_AVG1_100.csv'));
AUT(:,:) = importdata(strcat(File_Path2,'_AVG1_100.csv'));
f1=AUT(:,1);

% Plot Figure for DM EMI BGND and AUT

figure;
% % figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'Color','w');  %Make the figure background white
% subplot(2,1,1);
plot(f1,BGND(:,2),'b');
hold on;
plot(f1,AUT(:,2),'r');
hold off;
ylabel('Amplitude (dBm)');
xlabel('Frequency (MHz)')
title(strcat('Frequency Spectrum of DM EMI [',Path4,'] '));
legend('BGND',Path4);
ylim([-150 -70]);
% % ylim([0 0.5e-6]);
xlim([0 5]);
grid on;
ConvertPlot4Publication(strcat(Path1,Path4,'_DM'), 'fontsize', 12, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'pdf','off','eps','off','psfrag','off','fig','off')
close all;

% Plot Figure for CM EMI BGND and AUT
figure;
% % figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'Color','w');  %Make the figure background white
% subplot(2,1,1);
plot(f1,BGND(:,3),'b');
hold on;
plot(f1,AUT(:,3),'r');
hold off;
ylabel('Amplitude (dBm)');
xlabel('Frequency (MHz)')
title(strcat('Frequency Spectrum of CM EMI [',Path4,']'));
legend('BGND',Path4);
ylim([-150 -70]);
% % ylim([0 0.5e-6]);
xlim([0 5]);
grid on;
ConvertPlot4Publication(strcat(Path1,Path4,'_CM'), 'fontsize', 12, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'pdf','off','eps','off','psfrag','off','fig','off');
close all;

index=index+1;

end
