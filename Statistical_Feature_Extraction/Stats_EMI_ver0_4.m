% Compute features from Frequency domain EMI data using descriptive stats function
% Manoj Gulati
% IIIT-Delhi

% clear all previously stored variables
clear all;
close all;
clc;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/';
Path2 = 'PRT/';
Path3 = 'PRT5';
Path4 = 'FFT/';
Path5 = 'FD105_Features/';
File_Path = strcat(Path1,Path2,Path4,Path3);

No_of_traces = 1500;
L=105;
feature_vector = [];
feature = [];

% Fetch content from files taken from Redpitaya
M1=zeros(16384,2);
y1=zeros(L,1);
y2=zeros(L,1);
%
index=1;
while(index<No_of_traces+1)

load(strcat(File_Path,'_FFT',int2str(index),'.mat'));
feature_vector = matrix(1:L,3);
% 
% % Fetch content for Channel-1 (Vdm)
% y1(:,1)  = M1(1:L,1);
% % Fetch content for Channel-2 (Earth)
% y2(:,1)  = M1(1:L,2);
% 
temp = Desc_stats_ver0_1(abs(feature_vector));
feature = [feature temp];

display(int2str(index));
index=index+1;
end
save(strcat(Path1,Path5,Path3,'_FD_stat','.mat'),'feature');

