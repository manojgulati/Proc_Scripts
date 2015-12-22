% This script is meant to compute 2D Spectrogram using stacked FFT data.
% It takes averaged FFT data in mat file format
% Manoj Gulati
% IIIT-Delhi
% DOI: 21st Dec, 2015
% DOM: 21st Dec, 2015

clc;
clear all;
close all;
format long g;

Path1 = '/Users/manojgulati/Databin/MSMT1_20NOV/Smart_Meter_Data/';
% Path2 = 'Data/';

M1 = importdata(strcat(Path1,'2.csv'));

%%
[x1] = M1.data(:,1);
[x,y] = unique(round(M1.data(:,1)));

%%
ax=gca;
plot(unique(round(M1.data(y,1)))/1000000,M1.data(y,11));
xlim([1448.022267 1448.022667]);
% ax.XTicklabel = [UTC_to_date(1448022267) UTC_to_date(1448022667)];
