% Compute Statistical features from temporal stats data of EMI
% Manoj Gulati
% IIIT-Delhi

% clear all previously stored variables
clear all;
close all;
clc;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/';
Path2 = 'TD16384_Features_SET3_DM/';
Path3 = 'PRT';
Path5 = '_TD_stat.mat';
Path4 = 'compressed_features/FEAT500/';
File_Path = strcat(Path1,Path2,Path3);
temp = []; % Temp variable to store recovered desc stats features
feature_vector = []; % Features recovered from custom descriptive statistics function
f_index = 0; % 
No_of_instances = 5; % Number of appliance instances being used for analysis
offset = 0;
index=1;


while(index<No_of_instances+1)

load(strcat(Path1,Path2,Path3,int2str(index),Path5));

for d_index = 1:3
    for f_index = 1:17
        temp = feature_vector(f_index,1+offset:500+offset);
        feature(f_index,:) = Desc_stats_ver0_2(temp);
        save(strcat(Path1,Path2,Path4,Path3,int2str(index),'_TD_stat','_',int2str(d_index),'.mat'),'feature');
    end
offset = offset+500;    
end
offset = 0;
display(int2str(index));

index=index+1;
end





