% Compute features from Time domain EMI data using descriptive stats function
% Manoj Gulati
% IIIT-Delhi

% clear all previously stored variables
clear all;
close all;
clc;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/';
Path2 = 'PRT/';
Path3 = 'PRT5_';
Path4 = 'TD16384/'
File_Path = strcat(Path1,Path2,Path3);

No_of_traces = 1500;
L=16384;
feature_vector = [];

% Fetch content from files taken from Redpitaya
M1=zeros(16384,2);
y1=zeros(L,1);
y2=zeros(L,1);

index=1;
while(index<No_of_traces+1)

M1(:,:)=importdata(strcat(File_Path,int2str(index),'.csv'));

% Fetch content for Channel-1 (Vdm)
y1(:,1)  = M1(1:L,1);
% Fetch content for Channel-2 (Earth)
y2(:,1)  = M1(1:L,2);

% Adding offset as precribed by redpitaya wiki after measurement data collected using 50 ohm termination. 
% This will be added to compensate for avg. noise captured by AFE of Redpitaya when terminated with matched load.
% Default value is 75 and 28
y1  = y1 + 113;
y2  = y2 + 145;

% Scaling factor for digital to analog conversion of ADC values.
% Resolution = 2*Vp/2^14 i.e. 2*1.079V/16384 = 0.0001317 
y1=y1*0.000131;
y2=y2*0.000131;

% plot(y2);

feature = Desc_stats(y2);
feature_vector = [feature_vector feature];

display(int2str(index));
index=index+1;
end
save(strcat(Path1,Path2,Path4,Path3,'TD_stat','.mat'),'feature_vector');

