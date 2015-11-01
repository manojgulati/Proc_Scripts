% Script to collate EMI traces to compute probability distribution 
% Changes: (29-09-2015) Created script to collate EMI data

% Manoj Gulati
% IIIT-Delhi

% clear all previously stored variables
clear all;
close all;
clc;
format long e;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/';
% Path2 = 'LC/';
Path3 = 'BGN_LC5';
Path4 = 'TD_Collated_Data/';

% File_Path = strcat(Path1,Path2,Path3,'_');

No_of_traces = 1500;
L  = 16384;       %signal length
    
% Fetch content from files taken from Redpitaya
M1=zeros(16384,2);
y1=zeros(L,1);
y2=zeros(L,1);

% Initialising null vectors to store EMI samples
ampY_1 = [];
ampY_2 = [];

%%
% index=1;
% while(index<No_of_traces+1)
% 
% M1(:,:)=importdata(strcat(File_Path,int2str(index),'.csv'));
% 
% % Fetch content for Channel-1 (Vdm)
% y1(:,1)  = M1(1:L,1);
% % Fetch content for Channel-2 (Earth)
% y2(:,1)  = M1(1:L,2);
% 
% % Adding offset as precribed by redpitaya wiki after measurement data collected using 50 ohm termination. 
% % This will be added to compensate for avg. noise captured by AFE of Redpitaya when terminated with matched load.
% % Default value is 75 and 28
% y1  = y1 + 113;
% y2  = y2 + 145;
% 
% % Scaling factor for digital to analog conversion of ADC values.
% % Resolution = 2*Vp/2^14 i.e. 2*1.079V/16384 = 0.0001317 
% y1=y1*0.000131;
% y2=y2*0.000131;
% 
% % ampY_1 = [ampY_1; y1];
% ampY_2 = [ampY_2; y2];
% 
% index=index+1;
% end
% 
% %%
% save(strcat(Path1,Path4,Path3,'_TD.mat'),'ampY_2');

%% Plot normalised histogram to get shape of probability distribution
clc;
load(strcat(Path1,Path4,Path3,'_TD.mat'));
%

xbin_range = linspace(0,0.15,100);
[n,xout] = hist(abs(ampY_2),xbin_range);

% normalize freq. counts
norm_n = n/sum(n);

% plot histogram of this distribution
f=figure;
% plot(xbin_range,norm_n,'r-');
% hold on;
bar(xout,norm_n);
xlim([0 0.15]);
ylim([-0.001 0.2]);
title('BGN5');
xlabel('Amplitude (Volts)');
ylabel('Histogram');
grid on;
% saveas(f, strcat(Path1,Path4,Path3,'_PDF.png'));
ConvertPlot4Publication(strcat(Path1,Path4,'BGN5','_PDF.png'), 'fontsize', 12, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'eps','off','psfrag','off','fig','off');

close all;


