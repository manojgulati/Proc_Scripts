% K-means clustering on k-peak features extracted from CM EMI data for five
% class problem..
% Manoj Gulati
% IIITD
% DOM:24-05-2015

clc;
clear all;
close all;

Path1 = '/Users/manojgulati/Databin/';
Path2 = 'Plug [24-05-2015]/';
Path3 = 'KPeak_Features/';
Path4 = 'BGN1_';
Path5 = 'LC1_';
Path6 = 'LCD1_';
Path7 = 'CFL1_';
Path8 = 'CPU1_';
Path9 = 'PRT1_';

BGN = [];
LC1 = [];
LCD1 = [];
CFL1 = [];
CPU1 = [];
PRT1 = [];

BGN_Test = [];
LC1_Test = [];
LCD1_Test = [];
CFL1_Test = [];
CPU1_Test = [];
PRT1_Test = [];

disp('Loading training data');
No_of_traces = 50;
index=1;
while(index<No_of_traces+1)
    % load backrgound data for training
    load(strcat(Path1,Path2,Path3,Path4,int2str(index),'.mat'));
    BGN = [BGN matrix(:,1)];
    
    % load Appliance data for training
    load(strcat(Path1,Path2,Path3,Path5,int2str(index),'.mat'));
    LC1 = [LC1 matrix(:,1)];

    % load Appliance data for training
    load(strcat(Path1,Path2,Path3,Path6,int2str(index),'.mat'));
    LCD1 = [LCD1 matrix(:,1)];

    % load Appliance data for training
    load(strcat(Path1,Path2,Path3,Path7,int2str(index),'.mat'));
    CFL1 = [CFL1 matrix(:,1)];

    % load Appliance data for training
    load(strcat(Path1,Path2,Path3,Path8,int2str(index),'.mat'));
    CPU1 = [CPU1 matrix(:,1)];
    
    % load Appliance data for training
    load(strcat(Path1,Path2,Path3,Path9,int2str(index),'.mat'));
    CPU1 = [CPU1 matrix(:,1)];
    
index=index+1;
end

% Data for KNN training
X = [BGN'; LC1'; LCD'; CFL1'; CPU'; PRT';];
% Labels for KNN training
Y = [ones(50,1); 2*ones(50,1); 3*ones(50,1); 4*ones(50,1); 5*ones(50,1); 6*ones(50,1);];

disp('Starting learning phase using KNN');

mdl = ClassificationKNN.fit(X,Y);
% load(strcat(Path1,'Five_Class','_KNN_Learn_CM.mat'),'mdl');

%%

disp('Starting testing phase using KNN');

No_of_traces = 100;
index=51;
while(index<No_of_traces+1)
    
    % load backrgound data for testing
    load(strcat(Path1,Path2,Path3,Path4,int2str(index),'.mat'));
    BGN_Test = [BGN_Test matrix(:,1)];
    
    % load Appliance data for testing
    load(strcat(Path1,Path2,Path3,Path5,int2str(index),'.mat'));
    LC1_Test = [LC1_Test matrix(:,1)];

    % load Appliance data for testing
    load(strcat(Path1,Path2,Path3,Path6,int2str(index),'.mat'));
    LCD1_Test = [LCD1_Test matrix(:,1)];

    % load Appliance data for testing
    load(strcat(Path1,Path2,Path3,Path7,int2str(index),'.mat'));
    CFL1_Test = [CFL1_Test matrix(:,1)];

    % load Appliance data for testing
    load(strcat(Path1,Path2,Path3,Path8,int2str(index),'.mat'));
    CPU1_Test = [CPU1_Test matrix(:,1)];
    
    % load Appliance data for testing
    load(strcat(Path1,Path2,Path3,Path9,int2str(index),'.mat'));
    CPU1_Test = [CPU1_Test matrix(:,1)];
    
index=index+1;
end

Xnew = BGN_Test';
[label,score,cost] = predict(mdl,Xnew);
label

