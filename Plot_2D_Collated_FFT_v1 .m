% Plot FFT data in 2D by collating multiple FFT spectrum computed from EMI

% Manoj Gulati
% Energy Group
% IIIT-Delhi
% DOM: 23-Nov-2015

clc;
clear all;

Path3 = '/Users/manojgulati/Databin/MSMT1_20NOV/EMI_Data/EMI_AVG/';

% Load raw EMI data dump in to memory for computing FFT over sliding window
% of 10 seconds
loadContent=dir(Path3);

i=4;
while (i+1<length(loadContent))
    load(strcat(Path3,loadContent(i,1).name));
    
    CM_EMI(i,:) = CM_Data;
    DM_EMI(i,:) = DM_Data; 
    clear CM_Data;
    clear DM_Data;
    i=i+1;
end
%%
% Plot FFT data in 2D by collating all FFT spectrum retrieved from EMI data

imagesc(CM_EMI(:,1:1000)');









