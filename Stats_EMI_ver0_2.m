% Compute Statistical features from temporal stats data of EMI
% Manoj Gulati
% IIIT-Delhi

% clear all previously stored variables
clear all;
close all;
clc;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/';
Path2 = 'TD16384_Features/';
Path3 = 'PRT';
Path5 = '_TD_stat.mat';
Path4 = 'compressed_features/';
File_Path = strcat(Path1,Path2,Path3);

feature_vector = [];
f_index = 0;
No_of_traces = 5;

index=1;
while(index<No_of_traces+1)

load(strcat(Path1,Path2,Path3,int2str(index),Path5));

for f_index = 1:12
    feature(f_index,:) = Desc_stats_ver0_2(feature_vector(f_index,:));
end
% feature_vector = [feature_vector feature];

display(int2str(index));
save(strcat(Path1,Path2,Path4,Path3,int2str(index),'_TD_stat','.mat'),'feature');

index=index+1;
end





