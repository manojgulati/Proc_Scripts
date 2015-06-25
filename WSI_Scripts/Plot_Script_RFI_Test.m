clc;
clear all;


Path1 = '/Volumes/Elements/Experiment-29 May 2015 WSI/induction cooker/baseband/Processed Data/';
Path2 = 'BGN_0004';
Path3 = 'IND_0000';
Path4 = 'IND_0010';
Path5 = 'IND_0020';
Path6 = 'IND_0030';
Path7 = 'IND_0040';
Path8 = 'IND_0050';
Path9 = 'IND_0060';
Path10 = 'IND_0070';
Path11 = 'IND_0080';
Path12 = 'IND_0090';
Path13 = 'IND_0100';

load(strcat(Path1,Path2,'_RFI','.mat'),'sum_buffer');
BGN_RFI=sum_buffer;
load(strcat(Path1,Path3,'_RFI','.mat'),'sum_buffer');
AUT_RFI1=sum_buffer;
load(strcat(Path1,Path4,'_RFI','.mat'),'sum_buffer');
AUT_RFI2=sum_buffer;
load(strcat(Path1,Path5,'_RFI','.mat'),'sum_buffer');
AUT_RFI3=sum_buffer;
load(strcat(Path1,Path6,'_RFI','.mat'),'sum_buffer');
AUT_RFI4=sum_buffer;
load(strcat(Path1,Path7,'_RFI','.mat'),'sum_buffer');
AUT_RFI5=sum_buffer;
load(strcat(Path1,Path8,'_RFI','.mat'),'sum_buffer');
AUT_RFI6=sum_buffer;
load(strcat(Path1,Path9,'_RFI','.mat'),'sum_buffer');
AUT_RFI7=sum_buffer;
load(strcat(Path1,Path10,'_RFI','.mat'),'sum_buffer');
AUT_RFI8=sum_buffer;
load(strcat(Path1,Path11,'_RFI','.mat'),'sum_buffer');
AUT_RFI9=sum_buffer;
load(strcat(Path1,Path12,'_RFI','.mat'),'sum_buffer');
AUT_RFI10=sum_buffer;
load(strcat(Path1,Path13,'_RFI','.mat'),'sum_buffer');
AUT_RFI11=sum_buffer;

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
plot(f_axis,AUT_RFI1,'r-');
plot(f_axis,AUT_RFI2,'color',[0/255 255/255 155/255]);
plot(f_axis,AUT_RFI3,'color',[0/255 100/255 0/255]);
plot(f_axis,AUT_RFI4,'y');
plot(f_axis,AUT_RFI5,'color',[255/255 55/255 255/255]);
plot(f_axis,AUT_RFI6,'color',[140/255 155/255 140/255]);
plot(f_axis,AUT_RFI7,'color',[130/255 55/255 30/255]);
plot(f_axis,AUT_RFI8,'color',[84/255 84/255 84/255]);
plot(f_axis,AUT_RFI9,'color',[95/255 155/255 160/255]);
plot(f_axis,AUT_RFI10,'color',[135/255 206/255 250/255]);
plot(f_axis,AUT_RFI11,'color',[205/255 51/255 51/255]);

grid on;
ylim([-60 -25]);
xlim([-.2 .2]);
xlabel('Frequency (in MHz)');
ylabel('Amplitude (in dB)');

legend('BGND RFI','AUT RFI (1 cm)','AUT RFI (10 cm)','AUT RFI (20 cm)','AUT RFI (30 cm)','AUT RFI (40 cm)','AUT RFI (50 cm)','AUT RFI (60 cm)','AUT RFI (70 cm)','AUT RFI (80 cm)','AUT RFI (90 cm)','AUT RFI (100 cm)');

ConvertPlot4Publication(strcat(Path1,Path3), 'width',6,'fontsize', 8.5, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',1,'pdf','off','eps','off','psfrag','off','fig','off');
