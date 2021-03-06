% Script to plot time domain plots for CM and DM EMI data
% Changes: (24-09-2015) Created script to plot TD EMI data in IEEE format 

% Manoj Gulati
% IIIT-Delhi


% clear all previously stored variables
clear all;
close all;
clc;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/';
Path2 = 'CPU/';
Path3 = 'CPU1';
Path4 = 'Plots_TD_Journal_New/';
% Path4 = 'FFT256/'
File_Path = strcat(Path1,Path2,Path3,'_');

No_of_traces = 151;
L  = 16384;       %signal length
    
% Fetch content from files taken from Redpitaya
M1=zeros(16384,2);
y1=zeros(L,1);
y2=zeros(L,1);

% Initialising null vectors to store EMI samples
ampY_1 = zeros(L,1);
ampY_2 = zeros(L,1);

%%
index=151;
while(index<No_of_traces+1)

M1(:,:)=importdata(strcat(File_Path,int2str(index),'.csv'));

% Fetch content for Channel-1 (Vdm)
y1(:,1)  = M1(1:L,1);
% Fetch content for Channel-2 (Earth)
y2(:,1)  = M1(1:L,2);

% Adding offset as precribed by redpitaya wiki after measurement data collected using 50 ohm termination. 
% This will be added to compensate for avg. noise captured by AFE of Redpitaya when terminated with matched load.
% Default value is 75 and 28
y1  = y1 + 113;
y2  = y2 + 145;

% Scaling factor for digital to analog conversion of ADC values.
% Resolution = 2*Vp/2^14 i.e. 2*1.079V/16384 = 0.0001317 
y1=y1*0.000131;
y2=y2*0.000131;

ampY_1 = ampY_1+y1;
ampY_2 = ampY_2+y2;

index=index+1;
end
% Taking average of TD EMI data over n No_of_traces
ampY_1 = ampY_1/1;
ampY_2 = ampY_2/1;

%%
% % Configuration Parameters
fs = 15.625*(10^6);  %sample frequency in Hz
T  = 1/fs;        %sample period in s
t  = (0:L-1) * T; %time vector
t=t*1000;

plot(t',ampY_1,'r');
hold on;
plot(t',ampY_2,'b');
grid on;
xlim([0 max(t)]);
% ylim([-0.2 0.2]);
% ylim([-0.5 0.5]);
ylim([-1.2 1.2]);
xlabel('Time (in msec)');
ylabel('Amplitude (in Volts)');
legend('DM EMI Data','CM EMI Data');
% title('Printer Instance-1');
ConvertPlot4Publication(strcat(Path1,Path4,Path3,'_1.2'), 'fontsize', 10, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'pdf','off','eps','off','psfrag','off','fig','off');
%%

plot(t',ampY_1,'r');
hold on;
plot(t',ampY_2,'b');
grid on;
xlim([0 max(t)]);
ylim([-0.2 0.2]);
% ylim([-0.5 0.5]);
% ylim([-1.2 1.2]);
xlabel('Time (in msec)');
ylabel('Amplitude (in Volts)');
legend('DM EMI Data','CM EMI Data');
% title('Printer Instance-1');
ConvertPlot4Publication(strcat(Path1,Path4,Path3,'_0.2'), 'fontsize', 10, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'pdf','off','eps','off','psfrag','off','fig','off');


