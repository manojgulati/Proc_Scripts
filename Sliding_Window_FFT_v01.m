% This script is meant to compute FFT on real time EMI data collected using 
% Redpitaya and timestamped with UTC.
% Manoj Gulati
% IIIT-Delhi
% DOM: 21 June, 2015

clc;
clear all;
close all;

offset=0;

while (i+1<17940)

% Directory path to store computed FFT plots averaged over 10 second window
Path1 = '/Users/manojgulati/Documents/Processed Plots RT 18-06-15/';
Path2 = '/Users/manojgulati/Databin/';

% Load raw EMI data dump in to memory for computing FFT over sliding window
% of 10 seconds
loadContent=dir('/Users/manojgulati/Databin/');

No_of_traces = 20;

% Fetch content from files taken from Redpitaya
% M1=zeros(16384,2,4+No_of_traces);
for i = 4+offset:4+offset+No_of_traces-1
%     display(loadContent(i,1).name);
    M1(:,:,i-3)=dlmread(strcat(Path2,loadContent(i,1).name),'');
end

for j = 1:No_of_traces
    % Fetch content for Channel-1 (Vdm)
    y1(:,j)  = M1(:,1,j);
    % Fetch content for Channel-2 (Earth)
    y2(:,j)  = M1(:,2,j);
end

% Adding offset as precribed by redpitaya wiki after measurement data collected using 50 ohm termination. 
% This will be added to compensate for avg. noise captured by AFE of Redpitaya when terminated with matched load.
% Default value is 75 and 28
y1  = y1 + 96;
y2  = y2 + 125;

% Scaling factor for digital to analog conversion of ADC values.
% Resolution = 2*Vp/2^14 i.e. 2*1.079V/16384 = 0.0001317 
y1=y1*0.000131;
y2=y2*0.000131;

% Configuration Parameters
fs = 1.953*(10^6);  %sample frequency in Hz
T  = 1/fs;        %sample period in s
L  = 16384;       %signal length
t  = (0:L-1) * T; %time vector

%% Paragraph Break

% Initialising null vectors to store EMI samples
ampY_1 = zeros(L/2+1,No_of_traces);
ampY_2 = zeros(L/2+1,No_of_traces);

% Loop to compute FFT over 100 traces of EMI
for k = 1:No_of_traces
    % Computing spectrum for Differential Mode EMI 
    Y1(:,k)  = fft(y1(:,k))/L;
    % Computing spectrum for Common Mode EMI 
    Y2(:,k)  = fft(y2(:,k))/L;
    % Computing magnitude of Vdm and Vcm for length L/2
    ampY_1(:,k) = 2*abs(Y1(1:L/2+1,k));
    ampY_2(:,k) = 2*abs(Y2(1:L/2+1,k));
end

% Integrating the amplitude over 100 traces for averaging
AmpY_1 = sum(ampY_1,2);
AmpY_2 = sum(ampY_2,2);
% Averaging over 100 traces
AmpY_1 = AmpY_1/No_of_traces;
AmpY_2 = AmpY_2/No_of_traces;

% Computing f vector for length fs/2
f = fs/2*linspace(0,1,L/2+1);

%% Paragraph Break

% Plotting Complete FFT Spectrum for CM and DM EMI
Points = 8192;
f1 = f/1000000;

% figure;
%Plot spectrum.
% figure;
fig=figure('visible','off');
% figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'Color','w');  %Make the figure background white
subplot(2,1,1);
plot(f1,10*log10(1000*((AmpY_1.^2)/10^6)),'r');
% semilogx(f1,10*log10(1000*((AmpY_1.^2)/10^6)),'r');
% set(gca,'xlim',[0 5]);
ylabel('Amplitude|Y-DM|(dBm)');
title(strcat('Amplitude Spectrum of EMI {',Path2,'} '));
legend('DM EMI');
ylim([-145 -20]);
xlim([0 1]);
grid on;
hold on;
subplot(2,1,2);
plot(f1,10*log10(1000*((AmpY_2.^2)/10^6)),'b');
% semilogx(f1,10*log10(1000*((AmpY_2.^2)/10^6)),'b');
% set(gca,'xlim',[0 5]);
ylabel('Amplitude|Y-CM|(dBm)');
xlabel('Frequency (MHz)');
ylim([-150 -20]);
xlim([0 1]);
legend('CM EMI');
grid on;

% Function to plot as per IEEE publication specifications in 4 formats eps, fig, PDF and png
saveas(gcf,strcat(Path1,'FFT_X1_',loadContent(i-No_of_traces+1,1).name,'.png'));

close all;

offset = offset+20;
end



