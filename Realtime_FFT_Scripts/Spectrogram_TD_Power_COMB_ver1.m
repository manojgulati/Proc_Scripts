% Plotting script showing spectrogram of averaged EMI data and Time-domain 
% power data combined
% Manoj Gulati
% IIIT-Delhi
% DOI: 22st Dec, 2015
% DOM: 22st Dec, 2015

clc;
clear all;
close all;
format long g;

% Path for Averaged FFT data 
Path1 = '/Users/manojgulati/Databin/MSMT1_20NOV/';
Path4 = 'EMI_Data/';
Path2 = 'Data/';
% Path for Smart meter data 
Path3 = '/Users/manojgulati/Databin/MSMT1_20NOV/Smart_Meter_Data/';

% Load averaged FFT data in to 2D matrix M1 having rows specifying frequency 
% range and columns showing time duration of data measurements.
loadContent=dir(strcat(Path1,Path4,Path2,'*.mat'));
No_of_files = size(loadContent,1);
fs = 15.625*(10^6);  %sample frequency in Hz
L  = 16384;       %signal length
% Computing f vector for length fs/2
f = fs/2*linspace(0,1,L/2+1);
f1 = f/1000000;

for i=1:No_of_files
    load(strcat(Path1,Path4,Path2,loadContent(i,1).name));
    M1(:,i) = CM_Data;
    clear CM_Data;
end

% Print start and end timestamp of FFT data
clc;
display('Start TS:');
display(loadContent(1,1).name);
display('End TS:');
display(loadContent(No_of_files,1).name);

% Load time-domain smart meter data
M2 = importdata(strcat(Path3,'2.csv'));
[x1] = M2.data(:,1);
[x2,y2] = unique(round(M2.data(:,1)));

%%
% Timestamp for time domain and frequency domain plot
start_time = 1448022491;
end_time = 1448022501;
clc;

% Plot spectrogram using stacked FFT data retrived from averaged FFT frames
figure
subplot(2,1,1);
ax=gca;
plot(x2,M2.data(y2,11));
xlim([start_time end_time]);
% set(gca,'XTickLabel',[1:11]);
set(gca,'XTickLabel',[UTC_to_IST(start_time:end_time)],'FontSize',12);
rotateXLabels(gca,25);
xlabel('Time (in seconds)','FontSize',17);
ylabel('Real Power (in Watts)','FontSize',17);
grid on;

subplot(2,1,2);
x_lim = linspace(No_of_files,1,1);
imagesc(x_lim,f1,M1);
set(gca,'XTickLabel',[UTC_to_IST(start_time:end_time)],'FontSize',12);
rotateXLabels(gca,25);
% xlabel('Time (in seconds)');
ylabel('Frequency (in MHz)','FontSize',17);
h = colorbar;
ylabel(h, 'Amplitude (in dBm)','FontSize',17);
grid on;

% Function to plot as per IEEE publication specifications in 4 formats eps, fig, PDF and png
% ConvertPlot4Publication(strcat(Path1,'Spectrogram_TD_COMB'),'width',3,'fontsize', 10, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'pdf','off','eps','off','psfrag','off','fig','off');
