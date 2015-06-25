% K-means clustering on k-peak features extracted from RFI data for seven
% class problem..
% Manoj Gulati
% IIITD
% DOM:15-06-2015

clc;
clear all;
close all;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/ConvertPlot4Publication/WSI_Scripts/Data4Detection/KPeak_Features/';
%Path2 = 'Plug [24-05-2015]/';
%Path3 = 'KPeak_Features/';
Path4 = 'BGN';
Path5 = 'CFL';
Path6 = 'LC';
Path7 = 'UPS';
Path8 = 'DRILL';
Path9 = 'SMPS';
Path10 = 'INDUCTION';

Training_data=1799;
Testing_data=199;

BGN=[];
CFL=[];
LC=[];
UPS=[];
DRILL=[];
SMPS=[];
INDUCTION=[];

BGN_Test=[];
CFL_Test=[];
LC_Test=[];
UPS_Test=[];
DRILL_Test=[];
SMPS_Test=[];
INDUCTION_Test=[];


%%
disp('Loading training data');
No_of_traces = 1999;
index=801;
while(index<No_of_traces+1)
    % load backrgound data for training
    load(strcat(Path1,Path4,'_Kpeak_',int2str(index),'.mat'));
    BGN = [BGN matrix(:,1)];
    load(strcat(Path1,Path5,'_Kpeak_',int2str(index),'.mat'));
    CFL = [CFL matrix(:,1)];
    load(strcat(Path1,Path6,'_Kpeak_',int2str(index),'.mat'));
    LC = [LC matrix(:,1)];
    load(strcat(Path1,Path7,'_Kpeak_',int2str(index),'.mat'));
    UPS = [UPS matrix(:,1)];
    load(strcat(Path1,Path8,'_Kpeak_',int2str(index),'.mat'));
    DRILL = [DRILL matrix(:,1)];
    load(strcat(Path1,Path9,'_Kpeak_',int2str(index),'.mat'));
    SMPS = [SMPS matrix(:,1)];
    load(strcat(Path1,Path10,'_Kpeak_',int2str(index),'.mat'));
    INDUCTION = [INDUCTION matrix(:,1)];

index=index+1;
end
%%

% Data for KNN training
X = [BGN'; CFL'; LC'; UPS'; DRILL'; SMPS'; INDUCTION';];
% Labels for KNN training
Y = [ones(Training_data,1); 2*ones(Training_data,1); 3*ones(Training_data,1); 4*ones(Training_data,1); 5*ones(Training_data,1); 6*ones(Training_data,1); 7*ones(Training_data,1);];

disp('Starting learning phase using KNN');

mdl = ClassificationKNN.fit(X,Y);
save(strcat(Path1,'Five_Class','_KNN_Learn_CM.mat'),'mdl');

%%

disp('Starting testing phase using KNN');

No_of_traces = 1000;
index=801;
while(index<No_of_traces+1)
    
    % load backrgound data for training
    load(strcat(Path1,Path4,'_Kpeak_',int2str(index),'.mat'));
    BGN_Test = [BGN_Test matrix(:,1)];
    load(strcat(Path1,Path5,'_Kpeak_',int2str(index),'.mat'));
    CFL_Test = [CFL_Test matrix(:,1)];
    load(strcat(Path1,Path6,'_Kpeak_',int2str(index),'.mat'));
    LC_Test = [LC_Test matrix(:,1)];
    load(strcat(Path1,Path7,'_Kpeak_',int2str(index),'.mat'));
    UPS_Test = [UPS_Test matrix(:,1)];
    load(strcat(Path1,Path8,'_Kpeak_',int2str(index),'.mat'));
    DRILL_Test = [DRILL_Test matrix(:,1)];
    load(strcat(Path1,Path9,'_Kpeak_',int2str(index),'.mat'));
    SMPS_Test = [SMPS_Test matrix(:,1)];
    load(strcat(Path1,Path10,'_Kpeak_',int2str(index),'.mat'));
    INDUCTION_Test = [INDUCTION_Test matrix(:,1)];
    
index=index+1;
end
%%
clc;
Xnew = INDUCTION_Test';
for i=(1:200)
    [label(i,:),score,cost] = predict(mdl,Xnew(i,:));
end

% Display labels of classified features
clc;
display(size(find(label==1)));
display(size(find(label==2)));
display(size(find(label==3)));
display(size(find(label==4)));
display(size(find(label==5)));
display(size(find(label==6)));
display(size(find(label==7)));


