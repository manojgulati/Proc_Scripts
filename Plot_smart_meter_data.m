% Plot smart meter data collected from real time scripts
% Manoj Gulati
% Energy Group
% IIIT-Delhi

close all;
clc;

Path1 = '/Users/manojgulati/Databin/MSMT1_20NOV/Smart_Meter_Data/';
Path2 = '1';
M1(:,:)=importdata(strcat(Path1,Path2,'.csv'),',',1);

tr_length = size(M1.data(:,1),1);

%%

% plot(tr_length,M1.data(:,9));
% xlabel('Timestamp');
% ylabel('Frequency (Hz)');
% ylim([49.99 50.02]);
% % hold on;

figure;
plot(1:tr_length,M1.data(:,3));
xlabel('Timestamp');
grid on;
ylabel('Real Power (W)');

figure;
plot(1:tr_length,M1.data(:,4));
xlabel('Timestamp');
grid on;
ylabel('Reactive Power (VAR)');
