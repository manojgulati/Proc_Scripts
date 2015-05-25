% K-peak finding algorithm [Testing phase]

clc;
clear all;
close all;

load sunspot.dat
year=sunspot(:,1);
relNums=sunspot(:,2);

%%
[pks,locs] = findpeaks(relNums,'SORTSTR','descend');

%%
plot(year,relNums);
hold on;
plot(year(locs),pks,'r*');
