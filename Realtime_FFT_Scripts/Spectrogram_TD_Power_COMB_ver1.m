% Plotting script showing spectrogram of averaged EMI data and Time-domain 
% power data combined
% Manoj Gulati
% IIIT-Delhi
% DOI: 22st Dec, 2015
% DOM: 22st Dec, 2015

clc;
clear all;
close all;

% Path for Averaged FFT data 
Path1 = '/Users/manojgulati/Databin/MSMT1_20NOV/EMI_Data/';
Path2 = 'Data/';

% Load averaged FFT data in to 2D matrix M1 having rows specifying frequency 
% range and columns showing time duration of data measurements.
loadContent=dir(strcat(Path1,Path2,'*.mat'));
No_of_files = size(loadContent,1);
fs = 15.625*(10^6);  %sample frequency in Hz
L  = 16384;       %signal length
% Computing f vector for length fs/2
f = fs/2*linspace(0,1,L/2+1);
f1 = f/1000000;

for i=1:No_of_files
    load(strcat(Path1,Path2,loadContent(i,1).name));
    M1(:,i) = CM_Data;
    clear CM_Data;
end

% Print start and end timestamp of FFT data
clc;
display('Start TS:');
display(loadContent(1,1).name);
display('End TS:');
display(loadContent(No_of_files,1).name);

%%

% Plot spectrogram using stacked FFT data retrived from averaged FFT frames
figure
subplot(2,1,1);
xlim = linspace(No_of_files,1,1);
imagesc(xlim,f1,M1);
xlabel('Time (in seconds)');
ylabel('Frequency (in MHz)');
h = colorbar;
ylabel(h, 'dBm')

subplot(2,1,2);
xlim = linspace(No_of_files,1,1);
imagesc(xlim,f1,M1);
xlabel('Time (in seconds)');
ylabel('Frequency (in MHz)');
h = colorbar;
ylabel(h, 'dBm')