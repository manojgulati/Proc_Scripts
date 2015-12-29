% Plotting script showing spectrogram of averaged EMI data and Time-domain 
% power data combined
% Manoj Gulati
% IIIT-Delhi
% DOI: 22st Dec, 2015
% DOM: 28th Dec, 2015

clc;
clear all;
close all;
format long g;

% Path for Averaged FFT data 
Path1 = '/Users/manojgulati/Databin/MSMT_25DEC/CFL/';
Path4 = 'EMI_Data/';
Path2 = 'Data/';
% Path for Smart meter data 
Path3 = '/Users/manojgulati/Databin/MSMT_25DEC/CFL/Smart_Meter_Data/';
Path5 = '25-December-2015.csv';
% Load averaged FFT data in to 2D matrix M1 having rows specifying frequency 
% range and columns showing time duration of data measurements.
loadContent=dir(strcat(Path1,Path4,Path2,'*.mat'));
No_of_files = size(loadContent,1);
fs = 15.625*(10^6);  %sample frequency in Hz
del_t  = 1/fs;        %sample period in s
L  = 16384;       %signal length
t  = (0:L-1) * del_t; %time vector
T = L*del_t; % Total time of measurement
del_f = 1/T; % Min. Freq. resolution (in Hz)
% Computing f vector for length fs/2
f = (fs/2-1/T)*linspace(0,1,L/2);
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
M2 = importdata(strcat(Path3,Path5));
[x1] = M2(:,1);
[x2,y2] = unique(round(M2(:,1)));

%%
% Timestamp for time domain and frequency domain plot
start_time = 1451022708;
end_time = 1451022959;
time_slot = end_time - start_time;
clc;

% find vector of time domain data
x_begin = find(x2 == start_time);
x_end = find(x2 == end_time);


%% Plot spectrogram using stacked FFT data retrived from averaged FFT frames
% figure;
figure('units','normalized','outerposition',[0 0 1 1]);
t_axis = [0:50:time_slot];

ah1 = subplot(2,1,1);
% ax=gca;
plot([1:time_slot],M2(y2(x_begin:x_end),3));
xlim([1  time_slot]);
% % set(gca,'XLim',[start_time end_time]);
% % set(gca,'XTick',t_axis);
% % set(gca,'XTickLabel',t_axis,'FontSize',15);
xlabel('Time (in seconds)','FontSize',18);
ylabel('Real Power (in Watts)','FontSize',18);
grid on;

ah2 = subplot(2,1,2);
x_lim = t_axis;
imagesc(x_lim,f1(1:5244),M1(1:5244,:));
% set(gca,'XTickLabel',[t_axis],'FontSize',15);
xlabel('Time (in seconds)','FontSize',18);
ylabel('Frequency (in MHz)','FontSize',18);
h = colorbar;
ylabel(h, 'Amplitude (in dBm)','FontSize',18);
% grid on;

% find current position [x,y,width,height]
pos2 = get(ah2,'Position');
pos1 = get(ah1,'Position');
% set width of second axes equal to first
pos2(3) = pos1(3);
set(ah2,'Position',pos2)


% Function to plot as per IEEE publication specifications in 4 formats eps, fig, PDF and png
% ConvertPlot4Publication(strcat(Path1,'Spectrogram_TD_COMB'),'width',3,'fontsize', 10, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'pdf','off','eps','off','psfrag','off','fig','off');
% saveas(gcf,strcat(Path1,'Spectrogram_TD_COMB_visualize','.png'));
