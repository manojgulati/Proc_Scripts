% Compute features from Time domain EMI data using descriptive stats function
% Manoj Gulati
% IIIT-Delhi

% clear all previously stored variables
clear all;
close all;
clc;
f_index=2;
file_names = {'LC/BGN_LC1','LC/BGN_LC2','LC/BGN_LC3','LC/BGN_LC4','LC/BGN_LC5','LC/LC1','LC/LC2','LC/LC3','LC/LC4','LC/LC5','LCD/LCD1','LCD/LCD2','LCD/LCD3','LCD/LCD4','LCD/LCD5','CFL/CFL1','CFL/CFL2','CFL/CFL3','CFL/CFL4','CFL/CFL5','CPU/CPU1','CPU/CPU2','CPU/CPU3','CPU/CPU4','CPU/CPU5','PRT/PRT1','PRT/PRT2','PRT/PRT3','PRT/PRT4','PRT/PRT5'};
file_names1 = {'BGN_LC1','BGN_LC2','BGN_LC3','BGN_LC4','BGN_LC5','LC1','LC2','LC3','LC4','LC5','LCD1','LCD2','LCD3','LCD4','LCD5','CFL1','CFL2','CFL3','CFL4','CFL5','CPU1','CPU2','CPU3','CPU4','CPU5','PRT1','PRT2','PRT3','PRT4','PRT5'};
Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/';
% Path2 = '/';
Path3 = '_';
Path4 = 'TD16384_Features_SET3_DM/';
while(f_index<31)
    
File_Path = strcat(Path1,char(file_names(f_index)),Path3);

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

feature = Desc_stats_ver0_1(y1);
feature_vector = [feature_vector feature];

display(int2str(index));
index=index+1;
end

save(strcat(Path1,Path4,char(file_names1(f_index)),Path3,'TD_stat','.mat'),'feature_vector');

f_index=f_index+1;

end
