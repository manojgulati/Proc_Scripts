clc;
clear all;


Path1 = '/Volumes/Elements/Experiment-29 May 2015 WSI/induction cooker/baseband/Processed Data/';
Path2 = 'IND_0004';
Path3 = 'BGN_0004';
load(strcat(Path1,Path2,'_RFI','.mat'),'sum_buffer');
AUT_RFI=sum_buffer;
load(strcat(Path1,Path3,'_RFI','.mat'),'sum_buffer');
BGN_RFI=sum_buffer;
load(strcat(Path1,'f_axis','_RFI','.mat'),'f_axis');

figure
f_axis = f_axis/1000000;

plot(f_axis,BGN_RFI,'b');
% grid on;
% xlim([0 max(f_axis)]);
% ylim([-60 -35]);
% xlabel('Frequency (in MHz)');
% ylabel('Amplitude (in dB)');
hold on;
plot(f_axis,AUT_RFI,'r');
grid on;
% xlim([0 max(f_axis)]);
ylim([-60 -35]);
xlabel('Frequency (in MHz)');
ylabel('Amplitude (in dB)');

legend('BGND RFI','AUT RFI');

% ConvertPlot4Publication(strcat(Path1,Path3), 'fontsize', 10, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'pdf','off','eps','off','psfrag','off','fig','off');
