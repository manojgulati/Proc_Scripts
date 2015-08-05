% K-means clustering on k-peak features extracted from CM EMI data for five
% class problem..
% Manoj Gulati
% IIITD
% DOM:24-05-2015

clc;
clear all;
close all;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/';
Path2 = '/Trial_kNN_Analytics/';
Path3 = 'kpeak_features_CM/';
Path4 = 'BGN_LC5_';
Path5 = 'LC5_';
Path6 = 'LCD5_';
Path7 = 'CFL5_';
Path8 = 'CPU5_';
Path9 = 'PRT5_';

Path14 = 'BGN_LC4_';
Path15 = 'LC4_';
Path16 = 'LCD4_';
Path17 = 'CFL4_';
Path18 = 'CPU4_';
Path19 = 'PRT4_';

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
%%
disp('Loading training data');
No_of_traces = 1500;
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
    PRT1 = [PRT1 matrix(:,1)];
    
index=index+1;
end

% % Data for KNN training
X = [BGN'; LC1'; LCD1'; CFL1'; CPU1'; PRT1'];
% % Labels for KNN training
Y = [ones(1500,1); 2*ones(1500,1); 3*ones(1500,1); 4*ones(1500,1); 5*ones(1500,1); 6*ones(1500,1);];
% 
disp('Starting learning phase using KNN');
%% 
% mdl = ClassificationKNN.fit(X,Y);
% save(strcat(Path1,Path2,'Six_Class','_KNN_Learn_CM5.mat'),'mdl');
load(strcat(Path1,Path2,'Six_Class','_KNN_Learn_CM5.mat'),'mdl');

%%

disp('Starting testing phase using KNN');

No_of_traces = 1500;
index=1;
while(index<No_of_traces+1)
    
    % load backrgound data for testing
    load(strcat(Path1,Path2,Path3,Path14,int2str(index),'.mat'));
    BGN_Test = [BGN_Test matrix(:,1)];
    
    % load Appliance data for testing
    load(strcat(Path1,Path2,Path3,Path15,int2str(index),'.mat'));
    LC_Test = [LC_Test matrix(:,1)];

    % load Appliance data for testing
    load(strcat(Path1,Path2,Path3,Path16,int2str(index),'.mat'));
    LCD_Test = [LCD_Test matrix(:,1)];

    % load Appliance data for testing
    load(strcat(Path1,Path2,Path3,Path17,int2str(index),'.mat'));
    CFL_Test = [CFL_Test matrix(:,1)];

    % load Appliance data for testing
    load(strcat(Path1,Path2,Path3,Path18,int2str(index),'.mat'));
    CPU_Test = [CPU_Test matrix(:,1)];
    
    % load Appliance data for testing
    load(strcat(Path1,Path2,Path3,Path19,int2str(index),'.mat'));
    PRT_Test = [PRT_Test matrix(:,1)];
    
index=index+1;
end
%%
clc;
Xnew = BGN_Test';
for i=(1:1500)
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
for i=(1:1500)
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
for i=(1:1500)
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
for i=(1:1500)
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
for i=(1:1500)
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
for i=(1:1500)
    [label(i,:),score,cost] = predict(mdl,Xnew(i,:));
end
x1=sum((label)==1);
x2=sum((label)==2);
x3=sum((label)==3);
x4=sum((label)==4);
x5=sum((label)==5);
x6=sum((label)==6);
Z6=[x1 x2 x3 x4 x5 x6];
