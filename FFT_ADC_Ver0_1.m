% Matlab code for computing Frequency Spectrum of Raw ADC Values 
% Manoj Gulati
% IIIT-D

% clear all previously stored variables
clear all;
close all;
clc;

Path1 = '/Users/manojgulati/Databin/Experiments_22_July_2015/EXP7/';
Path2 = 'BGN1_';
File_Path = strcat(Path1,Path2);
No_of_traces = 100;

% Fetch content from files taken from XXXX
for i = 1:No_of_traces
    M1(:,:,i)=importdata(strcat(File_Path,int2str(i),'.csv'));
end

for i = 1:No_of_traces
    % Fetch content for Channel-1
    y1(:,i)  = M1(:,2,i);
end

% Adding offset if req. for calibration
% This will be added to compensate for avg. noise captured by AFE of XXXX.
y1  = y1 + 0;

% Scaling factor for digital to analog conversion of ADC values.
% Resolution = Vp/2^10 i.e. 5V/1023 = 
y1=y1*(5/1023);

% Configuration Parameters
fs = 15.625*(10^6);  %sample frequency in Hz
T  = 1/fs;        %sample period in s
L  = 16384;       %signal length
t  = (0:L-1) * T; %time vector
%%
% Plot time domain data
% figure;
% plot(y1(1:L),'r');
% ylim([-1.25 1.25]);
% xlim([0 16384]);  


%% Paragraph Break

% Initialising null vectors to store EMI samples
ampY_1 = zeros(L/2+1,No_of_traces);

% Loop to compute FFT over 100 traces of EMI
for i = 1:No_of_traces
    % Computing spectrum 
    Y1(:,i)  = fft(y1(:,i))/L;
    % Computing magnitude of Vraw for length L/2
    ampY_1(:,i) = 2*abs(Y1(1:L/2+1,i));
end

% % % Integrating the amplitude over 100 traces for averaging
% % AmpY_1 = sum(ampY_1,2);
% % % Averaging over 100 traces
% % AmpY_1 = AmpY_1/No_of_traces;

% Computing f vector for length fs/2
f = fs/2*linspace(0,1,L/2+1);

%% Paragraph Break

% Plotting Complete FFT Spectrum for CM and DM EMI
Points = L/2;
f1 = f/1000000;

% figure;
%Plot spectrum.
% figure;
% figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'Color','w');  %Make the figure background white
plot(f1,10*log10(1000*((AmpY_1.^2)/10^6)),'r');
ylabel('Amplitude|Yraw|(dBm)');
title(strcat('Amplitude Spectrum of ADC Values {',Path2,'} '));
legend('FFT Spectrum');
ylim([-150 -40]);
xlim([0.1 5]);
grid on;

% Function to plot as per IEEE publication specifications in 4 formats eps, fig, PDF and png
saveas(gcf,strcat(File_Path,'_visualize_X1_',int2str(Points),'.png'));
