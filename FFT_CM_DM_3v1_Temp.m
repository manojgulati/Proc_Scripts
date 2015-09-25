% Matlab code for computing Frequency Spectrum of Common Mode and Differential Mode components of Conducted EMI
% Manoj Gulati
% IIIT-D

% clear all previously stored variables
clear all;
close all;
clc;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/';
Path2 = 'CFL/';
Path3 = 'CFL1';
Path4 = 'Plots_FD_Journal/';
File_Path = strcat(Path1,Path2,Path3,'_');
No_of_traces = 100;

% Fetch content from files taken from Redpitaya
% M1=zeros(16384,2,No_of_traces);
for i = 1:No_of_traces
    M1(:,:,i)=importdata(strcat(File_Path,int2str(i),'.csv'));
end

for i = 1:No_of_traces
    % Fetch content for Channel-1 (Vdm)
    y1(:,i)  = M1(:,1,i);
    % Fetch content for Channel-2 (Earth)
    y2(:,i)  = M1(:,2,i);
end

% Adding offset as precribed by redpitaya wiki after measurement data collected using 50 ohm termination. 
% This will be added to compensate for avg. noise captured by AFE of Redpitaya when terminated with matched load.
% Default value is 75 and 28
y1  = y1 + 113;
y2  = y2 + 145;

% Scaling factor for digital to analog conversion of ADC values.
% Resolution = 2*Vp/2^14 i.e. 2*1.079V/16384 = 0.0001317 
y1=y1*0.000131;
y2=y2*0.000131;

% Configuration Parameters
% fs = 1.953125*(10^6);  %sample frequency in Hz
fs = 15.625*(10^6);  %sample frequency in Hz
T  = 1/fs;        %sample period in s
L  = 16384;       %signal length
t  = (0:L-1) * T; %time vector

% Dummy signals for testing algorithm (uncomment to verify FFT computation)
% f1 = 5*10^6;
% f2 = 10*10^6;
% y1 = 5*sin(2*pi*f1*t)+10*sin(2*pi*f2*t);%test signal
% y2 = 5*sin(2*pi*f1*t)-10*sin(2*pi*f2*t);%test signal
%
%%
% Plot time domain data
% figure;
% plot(y1(1:16384),'r');
% legend('DM EMI');
% ylim([-1.25 1.25]);
% xlim([0 16384]);  
% hold on;
% figure;
% plot(y2(1:16384),'b');
% legend('DM EMI','CM EMI');
% legend('CM EMI');
% ylim([-.2 .2]);
% xlim([0 16384]);


%% Paragraph Break

% Initialising null vectors to store EMI samples
ampY_1 = zeros(L/2+1,No_of_traces);
ampY_2 = zeros(L/2+1,No_of_traces);

% Loop to compute FFT over 100 traces of EMI
for i = 1:No_of_traces
    % Computing spectrum for Differential Mode EMI 
    Y1(:,i)  = fft(y1(:,i))/L;
    % Computing spectrum for Common Mode EMI 
    Y2(:,i)  = fft(y2(:,i))/L;
    % Computing magnitude of Vdm and Vcm for length L/2
    ampY_1(:,i) = 2*abs(Y1(1:L/2+1,i));
    ampY_2(:,i) = 2*abs(Y2(1:L/2+1,i));
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
% figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'Color','w');  %Make the figure background white
subplot(2,1,1);
plot(f1,10*log10(1000*((AmpY_1.^2)/10^6)),'r');
% semilogx(f1,10*log10(1000*((AmpY_1.^2)/10^6)),'r');
% set(gca,'xlim',[0 5]);
ylabel('|Y-DM|(dBm)');
title(strcat('Amplitude Spectrum of EMI'));
legend('DM EMI');
ylim([-150 -80]);
yticks = -150:20:-80;
set(gca,'YTick',yticks);
xlim([0.1 5]);
grid on;
hold on;

subplot(2,1,2);
plot(f1,10*log10(1000*((AmpY_2.^2)/10^6)),'b');
% semilogx(f1,10*log10(1000*((AmpY_2.^2)/10^6)),'b');
% set(gca,'xlim',[0 5]);
yticks = -150:20:-80;
set(gca,'YTick',yticks);
xlim([0.1 5]);
ylabel('|Y-CM|(dBm)');
xlabel('Frequency (MHz)');
ylim([-150 -80]);
% legend('CM EMI');
grid on;
%%
% Function to plot as per IEEE publication specifications in 4 formats eps, fig, PDF and png
% saveas(gcf,strcat(File_Path,'_visualize_X5_',int2str(Points),'.png'));
ConvertPlot4Publication(strcat(Path1,Path4,Path3), 'fontsize', 10, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'pdf','off','eps','off','psfrag','off','fig','off');

%%
% 
% hundred_avg1 = 10*log10(1000*((AmpY_1.^2)/10^6));
% hundred_avg2 = 10*log10(1000*((AmpY_2.^2)/10^6));
% 
% matrix_100(:,1) =f1;
% matrix_100(:,2) =hundred_avg1;
% matrix_100(:,3) =hundred_avg2;
% 
% csvwrite(strcat(File_Path,'AVG_100','.csv'),matrix_100);
