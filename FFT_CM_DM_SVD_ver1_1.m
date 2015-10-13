% Matlab code for computing Time Domain of Common Mode and Differential Mode components of Conducted EMI
% Manoj Gulati
% IIIT-D
% TD Data mgmt for dictionary learning using KSVD

% clear all previously stored variables
clear all;
close all;
clc;

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/';
AUT_Name1 = ['CFL/CFL1_';'CFL/CFL2_';'CFL/CFL3_';'CFL/CFL4_';'CFL/CFL5_';'LCD/LCD1_';'LCD/LCD2_';'LCD/LCD3_';'LCD/LCD4_';'LCD/LCD5_';'PRT/PRT1_';'PRT/PRT2_';'PRT/PRT3_';'PRT/PRT4_';'PRT/PRT5_'];
AUT_Name2 = ['LC/BGN_LC1_';'LC/BGN_LC2_';'LC/BGN_LC3_';'LC/BGN_LC4_';'LC/BGN_LC5_';];
AUT_Name3 = ['LC/LC1_';'LC/LC2_';'LC/LC3_';'LC/LC4_';'LC/LC5_';];

index=1;

while index<15;
    
Path2 = AUT_Name1(index,:);

File_Path = strcat(Path1,Path2);
No_of_traces = 1500;

% Fetch content from files taken from Redpitaya
% M1=zeros(16384,2,No_of_traces);
for i = 1:No_of_traces
    M1(:,:,i)=importdata(strcat(File_Path,int2str(i),'.csv'));
end
% for i = 1:No_of_traces
%     % Fetch content for Channel-1 (Vdm)
%     y1(:,i)  = downsample(M1(:,1,i),2);
%     % Fetch content for Channel-2 (Earth)
%     y2(:,i)  = downsample(M1(:,2,i),2);
% end

% M2_CM = reshape(downsample(M1(:,2,:),2),256,48000);
% M2_DM = reshape(downsample(M1(:,1,:),2),256,48000);

csvwrite(strcat(File_Path,'_TD1500_CM','.csv'),M1(:,2,:));
csvwrite(strcat(File_Path,'_TD1500_DM','.csv'),M1(:,1,:));

index=index+1;

end



