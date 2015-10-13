% Script for columnwise concat and learning dictionary on that.

clear all;
clc;

path1 = '/Users/manojgulati/Documents/Disaggregation_Data/';
path2 = 'PRT1';
% No_of_traces=100;
File_Path=strcat(path1,path2);
% for i = 1:No_of_traces
%     M1(:,:,i)=importdata(strcat(File_Path,int2str(i),'_.csv'));
% end
data=importdata(strcat(File_Path,'__TD1500_CM.csv'));
%%
% data = M1(:,1,:);

data1=[data(:,1:9600) data(:,19201:48000)];
% data1=[data(:,9601:48000)];

%%

param.L = 3;   % number of elements in each linear combination.
param.K = 10; % number of dictionary elements
param.numIteration = 50; % number of iteration to execute the K-SVD algorithm.

param.errorFlag = 0; % decompose signals until a certain error is reached. do not use fix number of coefficients.
%param.errorGoal = sigma;
param.preserveDCAtom = 0;

% Dict_matrix = rand(20,50);
% Coefficient_matrix = rand(50,1500);
% Input_data = Dict_matrix*Coefficient_matrix;
% 
% param.TrueDictionary = Dict_matrix;

%%%%%%%% initial dictionary: Dictionary elements %%%%%%%%
param.InitializationMethod =  'DataElements';

param.displayProgress = 1;
disp('Starting to  train the dictionary');

[Dictionary,output]  = KSVD(data1,param);

c=corr2(data1,Dictionary*output.CoefMatrix);
% disp(['The KSVD algorithm retrived ',num2str(output.ratio(end)),' atoms from the original dictionary']);

%%

Coeff_matrix = output.CoefMatrix;
csvwrite(strcat(File_Path,'_Dict2_CM','.csv'),Dictionary);
save(strcat(File_Path,'_Coeff2_CM.mat'),'Coeff_matrix');
