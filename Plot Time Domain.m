clc;
clear all;
close all;

% Dump images here
Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/Plots_TD_Journal_New#1/';
Path3 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/';
Path2 = 'CFL';
Path4 = 'CFL1';

% File_Path1 = strcat(Path3,Path2,Path4);
File_Path2 = strcat(Path3,Path2,'/',Path4);
M1(:,:) = importdata(strcat(File_Path2,'_1.csv'));

% Fetch content for Channel-1 (Vdm)
y1(:,1)  = M1(:,1);
% Fetch content for Channel-2 (Earth)
y2(:,1)  = M1(:,2);

% Adding offset as precribed by redpitaya wiki after measurement data collected using 50 ohm termination. 
% This will be added to compensate for avg. noise captured by AFE of Redpitaya when terminated with matched load.
% Default value is 75 and 28
y1  = y1 + 113;
y2  = y2 + 145;
fs=15.625*10^6;
delt=1/fs;
x_axis = [0:delt:16383*delt];
x_axis = 1000*x_axis;
% Scaling factor for digital to analog conversion of ADC values.
% Resolution = 2*Vp/2^14 i.e. 2*1.079V/16384 = 0.0001317 
y1=y1*0.000131;
y2=y2*0.000131;

figure;
set(gcf,'Color','w');  %Make the figure background white
plot(x_axis,y1,'r');
xlim([0 max(x_axis)]);
set(gca,'XTick',[0:0.2:max(x_axis)])
ylim([-0.1 0.1]);
xlabel('Time (msec)');
ylabel('Amplitude (Volts)');
grid on;
hold on;
plot(x_axis,y2,'b');
legend('DM EMI','CM EMI');
title(strcat('Time Domain plot for EMI [',Path2,']'));
ConvertPlot4Publication(strcat(Path1,Path4), 'fontsize', 12, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'pdf','off','eps','off','psfrag','off','fig','off');
hold off;
close all;




