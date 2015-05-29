% Simple script to compare features in EMI data
% Manoj G.
% IIITD
clc;
% clear all;

Path100='/Users/manojgulati/Databin/Plug [29-05-2015]/KPeak_Features/';

N=reshape(CPU1,1,500);
I = histc(N,N(1):N(end));
% find(I>1)

%%
Type1=find(I>1);
save(strcat(Path100,'LCD_Test_29.mat'),'Type1');
%%
Type2=find(I>1);
save(strcat(Path100,'LCD_Test_24.mat'),'Type2');



