% Matlab code for computing Frequency Spectrum of Common Mode and Differential Mode components of Conducted EMI and Dumping it as mat file
% Manoj Gulati
% IIIT-Delhi


% clear all previously stored variables
clear all;
close all;
clc;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/Raw_Data_EMI_Experiments/';
% Path2 = 'Mains CPU2/';
Path2 = 'CPU_DATA/';
Path3 = 'CPU2_';

Path4 = 'Single_FFT/';
File_Path = strcat(Path1,Path2,Path3);

No_of_traces = 100;
    
% Fetch content from files taken from Redpitaya
M1=zeros(16384,2);
y1=zeros(16384,1);
y2=zeros(16384,1);

index=1;
while(index<No_of_traces+1)

M1(:,:)=importdata(strcat(File_Path,int2str(index),'.csv'));

% Fetch content for Channel-1 (Vdm)
y1(:,1)  = M1(:,1);
% Fetch content for Channel-2 (Earth)
y2(:,1)  = M1(:,2);

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
fs = 15.625*(10^6);  %sample frequency in Hz
T  = 1/fs;        %sample period in s
L  = 16384;       %signal length
t  = (0:L-1) * T; %time vector


% Paragraph Break

% Initialising null vectors to store EMI samples
ampY_1 = zeros(L/2+1,1);
ampY_2 = zeros(L/2+1,1);

% Loop to compute FFT over 100 traces of EMI
% Computing spectrum for Differential Mode EMI 
Y1(:,1)  = fft(y1(:))/L;
% Computing spectrum for Common Mode EMI 
Y2(:,1)  = fft(y2(:))/L;
% Computing magnitude of Vdm and Vcm for length L/2
ampY_1(:,1) = 2*abs(Y1(1:L/2+1));
ampY_2(:,1) = 2*abs(Y2(1:L/2+1));

% Computing f vector for length fs/2
f = fs/2*linspace(0,1,L/2+1);
f1 = f/1000000;

trace_1 = 10*log10(1000*((ampY_1.^2)/10^6));
trace_2 = 10*log10(1000*((ampY_2.^2)/10^6));
% display('omkar');
% 
matrix(:,1) =f1;
matrix(:,2) =trace_1;
matrix(:,3) =trace_2;

save(strcat(Path1,Path4,Path3,'FFT',int2str(index),'.mat'),'matrix');


index=index+1;
end