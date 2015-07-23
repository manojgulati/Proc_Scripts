clc;
clear all;

Path1 = '/Users/manojgulati/Databin/Signal Analyser/20-07-2015/';
Path2 = 'Trace_0003';
File_Path = strcat(Path1,Path2);

df = csvread(strcat(File_Path,'.csv'),44);

%% Plotting Complete FFT Spectrum for CM and DM EMI
Points = 8192;
df(:,1) = df(:,1)/1000;
%%
% figure;
%Plot spectrum.
% figure;
% figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'Color','w');  %Make the figure background white
subplot(2,1,1);
plot(df(:,1),df(:,2),'r');
% semilogx(f1,10*log10(1000*((AmpY_1.^2)/10^6)),'r');
% set(gca,'xlim',[0 5]);
ylabel('Amplitude|Y-DM|(dBm)');
title(strcat('Amplitude Spectrum of EMI {',Path2,'} '));
legend('DM EMI');
ylim([-110 -40]);
% xlim([-0.1 1]);
grid on;
hold on;
subplot(2,1,2);
plot(df(:,1),df(:,2),'b');
% semilogx(f1,10*log10(1000*((AmpY_2.^2)/10^6)),'b');
% set(gca,'xlim',[0 5]);
ylabel('Amplitude|Y-CM|(dBm)');
xlabel('Frequency (MHz)');
ylim([-110 -40]);
% xlim([-0.1 1]);
% legend('CM EMI');
grid on;

% Function to plot as per IEEE publication specifications in 4 formats eps, fig, PDF and png
saveas(gcf,strcat(File_Path,'_visualize_X1_',int2str(Points),'.png'));