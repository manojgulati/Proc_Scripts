% K-means clustering on k-peak features extracted from CM EMI data using Descriptive stats.
% Manoj Gulati
% IIITD
% DOM:28-08-2015

clc;
clear all;
close all;

BGN = [];
LC1 = [];
LCD1 = [];
CFL1 = [];
CPU1 = [];
PRT1 = [];

BGN_Test = [];
LC_Test = [];
LCD_Test = [];
CFL_Test = [];
CPU_Test = [];
PRT_Test = [];
feat_len = [13 14 16 15 10 12 1 5 11 17];
% feat_len = [1:15];
temp_var = 12;
dim = 1;
%%
Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015';
Path2 = '/TD16384_Features_SET3_CM/compressed_features/FEAT500/';
Path3 = strcat('DIM',int2str(dim),'/');

app_instance_train = 1;
Path4 = strcat('BGN_LC',int2str(app_instance_train),'_');
Path5 = strcat('LC',int2str(app_instance_train),'_');
Path6 = strcat('LCD',int2str(app_instance_train),'_');
Path7 = strcat('CFL',int2str(app_instance_train),'_');
Path8 = strcat('CPU',int2str(app_instance_train),'_');
Path9 = strcat('PRT',int2str(app_instance_train),'_');

app_instance = 2;
Path14 = strcat('BGN_LC',int2str(app_instance),'_');
Path15 = strcat('LC',int2str(app_instance),'_');
Path16 = strcat('LCD',int2str(app_instance),'_');
Path17 = strcat('CFL',int2str(app_instance),'_');
Path18 = strcat('CPU',int2str(app_instance),'_');
Path19 = strcat('PRT',int2str(app_instance),'_');

No_of_traces = 5;
No_of_data_traces = 5;
%
disp('Loading training data');

index=1;
while(index<No_of_data_traces+1)
    % load backrgound data for training
    load(strcat(Path1,Path2,Path4,'TD_stat_',int2str(No_of_data_traces),'.mat'));
    BGN = [BGN feature(feat_len,dim)];
    
    % load Appliance data for training
    load(strcat(Path1,Path2,Path5,'TD_stat_',int2str(No_of_data_traces),'.mat'));
    LC1 = [LC1 feature(feat_len,dim)];
    
    % load Appliance data for training
    load(strcat(Path1,Path2,Path6,'TD_stat_',int2str(No_of_data_traces),'.mat'));
    LCD1 = [LCD1 feature(feat_len,dim)];

    % load Appliance data for training
    load(strcat(Path1,Path2,Path7,'TD_stat_',int2str(No_of_data_traces),'.mat'));
    CFL1 = [CFL1 feature(feat_len,dim)];

    % load Appliance data for training
    load(strcat(Path1,Path2,Path8,'TD_stat_',int2str(No_of_data_traces),'.mat'));
    CPU1 = [CPU1 feature(feat_len,dim)];
    
    % load Appliance data for training
    load(strcat(Path1,Path2,Path9,'TD_stat_',int2str(No_of_data_traces),'.mat'));
    PRT1 = [PRT1 feature(feat_len,dim)];
    
index=index+1;
end

%% % Data for KNN training
X = [BGN'; LC1'; LCD1'; CFL1'; CPU1'; PRT1'];

%%
disp('Starting learning phase using KMeans Clustering');

% Training Classifier
% rng default; % Initialise random number generator for reproducibility
[idx,c] = kmeans(X,6,'start','uniform', 'emptyaction','singleton');

% load('idx_mat.mat');
% load('centroid.mat');
clc;
sequence = [idx(1) idx(6) idx(11) idx(16) idx(21) idx(26) ]
%%
%
disp('Starting testing phase using KMeans');

index=1;
while(index<No_of_data_traces+1)
    
    % load backrgound data for testing
    load(strcat(Path1,Path2,Path14,'TD_stat_',int2str(No_of_data_traces),'.mat'));
    BGN_Test = [BGN_Test feature(feat_len,dim)];
    
    % load Appliance data for testing
    load(strcat(Path1,Path2,Path15,'TD_stat_',int2str(No_of_data_traces),'.mat'));
    LC_Test = [LC_Test feature(feat_len,dim)];

    % load Appliance data for testing
    load(strcat(Path1,Path2,Path16,'TD_stat_',int2str(No_of_data_traces),'.mat'));
    LCD_Test = [LCD_Test feature(feat_len,dim)];

    % load Appliance data for testing
    load(strcat(Path1,Path2,Path17,'TD_stat_',int2str(No_of_data_traces),'.mat'));
    CFL_Test = [CFL_Test feature(feat_len,dim)];

    % load Appliance data for testing
    load(strcat(Path1,Path2,Path18,'TD_stat_',int2str(No_of_data_traces),'.mat'));
    CPU_Test = [CPU_Test feature(feat_len,dim)];
    
    % load Appliance data for testing
    load(strcat(Path1,Path2,Path19,'TD_stat_',int2str(No_of_data_traces),'.mat'));
    PRT_Test = [PRT_Test feature(feat_len,dim)];
    
index=index+1;
end
%
% clc;
x = [];
Z1=zeros(6,1);
Z2=zeros(6,1);
Z3=zeros(6,1);
Z4=zeros(6,1);
Z5=zeros(6,1);
Z6=zeros(6,1);
% Infer the label for test data of AUT1
Xnew = BGN_Test';
for i=(1:No_of_traces)
    for app_index = 1:6
        x(app_index) = norm((Xnew(i,:)-c(app_index,:)),2);
    end
    [M,I] = min(x);
    Z1(I)=Z1(I)+1;    
end

% Infer the label for test data of AUT1
Xnew = LC_Test';
for i=(1:No_of_traces)
    for app_index = 1:6
        x(app_index) = norm((Xnew(i,:)-c(app_index,:)),2);
    end
    [M,I] = min(x);
    Z2(I)=Z2(I)+1;    
end

% Infer the label for test data of AUT1
Xnew = LCD_Test';
for i=(1:No_of_traces)
    for app_index = 1:6
        x(app_index) = norm((Xnew(i,:)-c(app_index,:)),2);
    end
    [M,I] = min(x);
    Z3(I)=Z3(I)+1;    
end

% Infer the label for test data of AUT1
Xnew = CFL_Test';
for i=(1:No_of_traces)
    for app_index = 1:6
        x(app_index) = norm((Xnew(i,:)-c(app_index,:)),2);
    end
    [M,I] = min(x);
    Z4(I)=Z4(I)+1;    
end

% Infer the label for test data of AUT1
Xnew = CPU_Test';
for i=(1:No_of_traces)
    for app_index = 1:6
        x(app_index) = norm((Xnew(i,:)-c(app_index,:)),2);
    end
    [M,I] = min(x);
    Z5(I)=Z5(I)+1;    
end

% Infer the label for test data of AUT1
Xnew = PRT_Test';
for i=(1:No_of_traces)
    for app_index = 1:6
        x(app_index) = norm((Xnew(i,:)-c(app_index,:)),2);
    end
    [M,I] = min(x);
    Z6(I)=Z6(I)+1;    
end
 
Z = [Z1'; Z2'; Z3'; Z4'; Z5'; Z6';];
Z=Z./10;
%
save(strcat(Path1,Path2,Path3, 'Result_',int2str(temp_var),'.mat'),'Z');
save(strcat(Path1,Path2,Path3, 'Idx_',int2str(temp_var),'.mat'),'idx');
save(strcat(Path1,Path2,Path3, 'Centroid_',int2str(temp_var),'.mat'),'c');
%







