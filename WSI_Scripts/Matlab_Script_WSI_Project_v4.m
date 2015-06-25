% Compute FFT frame after averaging over 2000 frames and plot in publication format
clc;
clear all; 
close all;
clear all;
clc;

% Import csv file having measured RFI in RF Band (downconverted for sampling at Fs) and having a bandwidth of Fs.
Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/ConvertPlot4Publication/WSI_Scripts/Data4Detection/INDUCTION/';
Path2 = 'IND_0004'; % Change this name based on name of appliance under test
Path3 = '.csv';
Path4 = '/Users/manojgulati/Documents/Algo_Testing_Data/ConvertPlot4Publication/WSI_Scripts/Data4Detection/EXTRACTED_FFT/';

M = importdata(strcat(Path1,Path2,Path3));
% buffer(:,:)= zeros(100000,1999);
sum_buffer = zeros(1000,1);

% Running an iterative loop to dump 20 FFT plots from 2 Million data point
index = 1;
offset = 0;
while index<2000

% NB: We will be using 1000 points for computing this FFT out of 2 Million points dumped

% Central Frequency of RFI band 
Fc = 0*10^9;
% Loaded RFI Signal
x = M(1+offset:index*1000);
% Length of signal
% L = 100;                      
L = 1000;                      
% Frequency of signal source (Only for simulation)
% f = .1*10^9;                   
% Sampling frequency
Fs = 2*10^6;                    
% Sample time (Only for simulation)
% delt = 1/Fs;                     
% Time vector (Only for simulation)
% t = (0:L)*delt;                
% Simulating a sinusoid (Only for simulation)
% x = 0.8*sin(2*pi*f*t);
% Computing Frequency Axis
f_axis = -Fs/2+1:Fs/L:Fs/2;
% Adding Fc to shift RFI to RF baseband
f_axis = f_axis+Fc;
% Compute FFT
sig_FFT = 2*fft(x)/L;
% buffer(:,index) = sig_FFT;
buffer1 = 10*log10(fftshift(abs(sig_FFT)));

% sum_buffer = sum_buffer + buffer1;

save(strcat(Path4,'INDUCTION','_RFI_',int2str(index),'.mat'),'buffer1');

index = index+1;
offset = offset+1000;
end

%sum_buffer = sum_buffer./1999;

%
%figure;
%plot(f_axis,sum_buffer);
%grid on;

% ConvertPlot4Publication(Path2, 'fontsize', 10, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'pdf','off','eps','off','psfrag','off','fig','off');

% saveas(gcf,strcat(Path2,'_',int2str(index)),'png');
% save(strcat(Path1,Path2,'_RFI','.mat'),'sum_buffer');
save(strcat(Path1,'f_axis','_RFI','.mat'),'f_axis');
