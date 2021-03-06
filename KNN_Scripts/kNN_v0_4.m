% kNN clustering on k-peak features extracted from CM EMI data using Descriptive stats.
% Manoj Gulati
% IIITD
% DOM:15-09-2015

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
% feat_len = [1:17];
temp_var = 54;
app_instance_train = 5;
app_instance = 4;

dim = 4;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015';
Path2 = '/TD16384_Features_SET3_DM/compressed_features/FEAT150/';
Path3 = strcat('DIM',int2str(dim),'/');

Path4 = strcat('BGN_LC',int2str(app_instance_train),'_');
Path5 = strcat('LC',int2str(app_instance_train),'_');
Path6 = strcat('LCD',int2str(app_instance_train),'_');
Path7 = strcat('CFL',int2str(app_instance_train),'_');
Path8 = strcat('CPU',int2str(app_instance_train),'_');
Path9 = strcat('PRT',int2str(app_instance_train),'_');

Path14 = strcat('BGN_LC',int2str(app_instance),'_');
Path15 = strcat('LC',int2str(app_instance),'_');
Path16 = strcat('LCD',int2str(app_instance),'_');
Path17 = strcat('CFL',int2str(app_instance),'_');
Path18 = strcat('CPU',int2str(app_instance),'_');
Path19 = strcat('PRT',int2str(app_instance),'_');

No_of_traces = 10;
No_of_data_traces = 10;
%
disp('Loading training data');

index=1;
while(index<No_of_data_traces+1)
    % load backrgound data for training
    load(strcat(Path1,Path2,Path4,'TD_stat_',int2str(index),'.mat'));
    BGN = [BGN feature(feat_len,dim)];
%     disp('om1');
    % load Appliance data for training
    load(strcat(Path1,Path2,Path5,'TD_stat_',int2str(index),'.mat'));
    LC1 = [LC1 feature(feat_len,dim)];
    
    % load Appliance data for training
    load(strcat(Path1,Path2,Path6,'TD_stat_',int2str(index),'.mat'));
    LCD1 = [LCD1 feature(feat_len,dim)];

    % load Appliance data for training
    load(strcat(Path1,Path2,Path7,'TD_stat_',int2str(index),'.mat'));
    CFL1 = [CFL1 feature(feat_len,dim)];

    % load Appliance data for training
    load(strcat(Path1,Path2,Path8,'TD_stat_',int2str(index),'.mat'));
    CPU1 = [CPU1 feature(feat_len,dim)];
    
    % load Appliance data for training
    load(strcat(Path1,Path2,Path9,'TD_stat_',int2str(index),'.mat'));
    PRT1 = [PRT1 feature(feat_len,dim)];
%     disp('om6');
index=index+1;
end

%% % Data for KNN training
X = [BGN'; LC1'; LCD1'; CFL1'; CPU1'; PRT1'];
% % Labels for KNN training
Y = [ones(No_of_traces,1); 2*ones(No_of_traces,1); 3*ones(No_of_traces,1); 4*ones(No_of_traces,1); 5*ones(No_of_traces,1); 6*ones(No_of_traces,1);];

% disp('Starting learning phase using KNN');
%
% mdl = ClassificationKNN.fit(X,Y,'NumNeighbors',3);    
% save(strcat(Path1,Path2,Path3,'Six_Class','_KNN_Learn_CM',int2str(app_instance_train),'_',int2str(feat_len),'.mat'),'mdl');
load(strcat(Path1,Path2,Path3,'Six_Class','_KNN_Learn_CM',int2str(app_instance_train),'_',int2str(feat_len),'.mat'),'mdl');

%%
disp('Starting testing phase using KNN');

t_index=1;
while(t_index<No_of_data_traces+1)
    
    % load backrgound data for testing
    load(strcat(Path1,Path2,Path14,'TD_stat_',int2str(t_index),'.mat'));
    BGN_Test = [BGN_Test feature(feat_len,dim)];
    
    % load Appliance data for testing
    load(strcat(Path1,Path2,Path15,'TD_stat_',int2str(t_index),'.mat'));
    LC_Test = [LC_Test feature(feat_len,dim)];

    % load Appliance data for testing
    load(strcat(Path1,Path2,Path16,'TD_stat_',int2str(t_index),'.mat'));
    LCD_Test = [LCD_Test feature(feat_len,dim)];

    % load Appliance data for testing
    load(strcat(Path1,Path2,Path17,'TD_stat_',int2str(t_index),'.mat'));
    CFL_Test = [CFL_Test feature(feat_len,dim)];

    % load Appliance data for testing
    load(strcat(Path1,Path2,Path18,'TD_stat_',int2str(t_index),'.mat'));
    CPU_Test = [CPU_Test feature(feat_len,dim)];
    
    % load Appliance data for testing
    load(strcat(Path1,Path2,Path19,'TD_stat_',int2str(t_index),'.mat'));
    PRT_Test = [PRT_Test feature(feat_len,dim)];
    
t_index=t_index+1;
end
%%
clc;
Xnew = BGN_Test';
for i=(1:No_of_traces)
    [label(i,:),score,cost] = predict(mdl,Xnew(i,:));
end
x1=sum((label)==1);
x2=sum((label)==2);
x3=sum((label)==3);
x4=sum((label)==4);
x5=sum((label)==5);
x6=sum((label)==6);
Z1=[x1 x2 x3 x4 x5 x6];

Xnew = LC_Test';
for i=(1:No_of_traces)
    [label(i,:),score,cost] = predict(mdl,Xnew(i,:));
end
x1=sum((label)==1);
x2=sum((label)==2);
x3=sum((label)==3);
x4=sum((label)==4);
x5=sum((label)==5);
x6=sum((label)==6);
Z2=[x1 x2 x3 x4 x5 x6];

Xnew = LCD_Test';
for i=(1:No_of_traces)
    [label(i,:),score,cost] = predict(mdl,Xnew(i,:));
end
x1=sum((label)==1);
x2=sum((label)==2);
x3=sum((label)==3);
x4=sum((label)==4);
x5=sum((label)==5);
x6=sum((label)==6);
Z3=[x1 x2 x3 x4 x5 x6];

Xnew = CFL_Test';
for i=(1:No_of_traces)
    [label(i,:),score,cost] = predict(mdl,Xnew(i,:));
end
x1=sum((label)==1);
x2=sum((label)==2);
x3=sum((label)==3);
x4=sum((label)==4);
x5=sum((label)==5);
x6=sum((label)==6);
Z4=[x1 x2 x3 x4 x5 x6];

Xnew = CPU_Test';
for i=(1:No_of_traces)
    [label(i,:),score,cost] = predict(mdl,Xnew(i,:));
end
x1=sum((label)==1);
x2=sum((label)==2);
x3=sum((label)==3);
x4=sum((label)==4);
x5=sum((label)==5);
x6=sum((label)==6);
Z5=[x1 x2 x3 x4 x5 x6];

Xnew = PRT_Test';
for i=(1:No_of_traces)
    [label(i,:),score,cost] = predict(mdl,Xnew(i,:));
end
x1=sum((label)==1);
x2=sum((label)==2);
x3=sum((label)==3);
x4=sum((label)==4);
x5=sum((label)==5);
x6=sum((label)==6);
Z6=[x1 x2 x3 x4 x5 x6];

Z = [Z1; Z2; Z3; Z4; Z5; Z6;];
Z=Z./No_of_traces;
% avg = sum(diag(Z))/6;
eval(sprintf('T%d = Z;',app_instance));
%
save(strcat(Path1, Path2,Path3, 'Result_',int2str(temp_var),'_',int2str(app_instance),'_',int2str(feat_len),'.mat'),sprintf('T%d',app_instance));




