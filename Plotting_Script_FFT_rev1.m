% % Plotting script for FFT Spectrum
clc;
clear all;

%
AUT_Name = ['LC1'; 'LC2'; 'LC3'; 'LC4';'LC5'];
AUT_Name1 = ['CFL1';'CFL2';'CFL3';'CFL4';'CFL5';'LCD1';'LCD2';'LCD3';'LCD4';'LCD5';'CPU1';'CPU2';'CPU3';'CPU4';'CPU5';'PRT1';'PRT2';'PRT3';'PRT4';'PRT5';];

index=16;

while index<17;
    
% Dump images here
Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/Plots_FD_Journal_New/';
Path3 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/Processed_FFT/';
Path2 = 'BGN_';
Path4 = AUT_Name1(index,:);
File_Path1 = strcat(Path3,Path2,Path4);
File_Path2 = strcat(Path3,Path4);

BGND(:,:) = importdata(strcat(File_Path1,'_AVG2_100.csv'));
AUT(:,:) = importdata(strcat(File_Path2,'_AVG2_100.csv'));
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
title(strcat('Frequency Spectrum of DM EMI [','PRT1','] '));
legend('BGN',Path4);
ylim([-150 -70]);
% % ylim([0 0.5e-6]);
xlim([0 5]);
grid on;
ConvertPlot4Publication(strcat(Path1,'PRT1','_DM'), 'fontsize', 12, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'eps','off','psfrag','off','fig','off')
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
title(strcat('Frequency Spectrum of CM EMI [','PRT1',']'));
legend('BGN',Path4);
ylim([-150 -70]);
% % ylim([0 0.5e-6]);
xlim([0 5]);
grid on;
ConvertPlot4Publication(strcat(Path1,'PRT1','_CM'), 'fontsize', 12, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'eps','off','psfrag','off','fig','off');
close all;

index=index+1;

end
