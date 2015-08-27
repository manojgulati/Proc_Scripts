% K-means clustering on k-peak features extracted from CM EMI data for two
% class problem..
% Manoj Gulati
% IIITD
% DOM:22-05-2015

clc;
clear all;
close all;

Path1 = '/Users/manojgulati/Databin/';
Path2 = 'Plug/';
Path3 = 'BGN1_';
Path5 = 'LC1_';
Path4 = 'KPeak_Features/';
AUT = [];
BGN = [];
AUT_Test = [];
BGN_Test = [];
disp('Loading training data');
No_of_traces = 50;
index=1;
while(index<No_of_traces+1)
    % load backrgound data for training
    load(strcat(Path1,Path2,Path4,Path3,int2str(index),'.mat'));
    BGN = [BGN matrix(:,1)];
    
    % load Appliance data for training
    load(strcat(Path1,Path2,Path4,Path5,int2str(index),'.mat'));
    AUT = [AUT matrix(:,1)];

index=index+1;
end

% Data for KNN training
X = [BGN'; AUT';];
% Labels for KNN training
Y = [ones(50,1); 2*ones(50,1);];

disp('Starting learning phase using KNN');

mdl = ClassificationKNN.fit(X,Y);
% load(strcat(Path1,'Five_Class','_KNN_Learn_CM.mat'),'mdl');

%%

disp('Starting testing phase using KNN');

No_of_traces = 100;
index=51;
while(index<No_of_traces+1)
    % load backrgound data for training
    load(strcat(Path1,Path2,Path4,Path3,int2str(index),'.mat'));
    BGN_Test = [BGN_Test matrix(:,1)];
    
    % load Appliance data for training
    load(strcat(Path1,Path2,Path4,Path5,int2str(index),'.mat'));
    AUT_Test = [AUT_Test matrix(:,1)];
    
    
    
index=index+1;
end

Xnew = BGN_Test';
[label,score,cost] = predict(mdl,Xnew);
label

