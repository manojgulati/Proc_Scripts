% Signal Source
clc;
clear all; 
close all;
clear all;
clc;

% Import csv file having measured RFI in RF Band (downconverted for sampling at Fs) and having a bandwidth of Fs.
Path1 = '/Users/manojgulati/Documents/MATLAB/WSI_Scripts/';
Path2 = 'CFL_0004'; % Change this name based on name of appliance under test
Path3 = '.csv';

M = importdata(strcat(Path1,Path2,Path3));
buffer(:,:)= zeros(100000,19);
sum_buffer = zeros(100000,1);

% Running an iterative loop to dump 20 FFT plots from 2 Million data point
index = 1;
offset = 0;
while index<20

% NB: We will be using 1 Lakh points for computing this FFT out of 10 Million points dumped

% Central Frequency of RFI band 
Fc = 0*10^9;
% Loaded RFI Signal
x = M(1+offset:index*100000);
% Length of signal
% L = 100;                      
L = 100000;                      
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
% sum_buffer = sum_buffer + buffer(:,index);
sum_buffer = sum_buffer + buffer1;

index = index+1;
offset = offset+100000;
end

sum_buffer = sum_buffer./19;
%%
figure;
plot(f_axis,sum_buffer);
grid on;
% saveas(gcf,strcat(Path2,'_',int2str(index)),'png');
