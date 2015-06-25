clear all;
clc;

% index=1;
% while index<101

Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/ConvertPlot4Publication/WSI_Scripts/UPS/';
% Path2 = 'BGN_';
Path3 = 'UPS_0003_RFI';
Path6 = '.mat';
Path5 = 'f_axis_RFI.mat';

% File_Path1 = strcat(Path1,Path2,Path3,Path4,int2str(index),Path6);
File_Path2 = strcat(Path1,Path3,Path6);
File_Path3 = strcat(Path1,Path5);

load(File_Path3);
% Data_BGN = Vect1;
% clear Vect1;

load(File_Path2);
Data_RFI = sum_buffer;
Data_FREQ = f_axis';
% clear Vect1;
% Start Gausssian Curve Fit Learning

% [x,y] = titanium;
x=Data_FREQ(401:600);
y=Data_RFI(401:600);
f = fit(x,y,'gauss8');
%
data =zeros(1,24);

j=1;
data(j)=f.a1;
j=j+1;
data(j)=f.b1;
j=j+1;
data(j)=f.c1;
j=j+1;
data(j)=f.a2;
j=j+1;
data(j)=f.b2;
j=j+1;
data(j)=f.c2;
j=j+1;
data(j)=f.a3;
j=j+1;
data(j)=f.b3;
j=j+1;
data(j)=f.c3;
j=j+1;
data(j)=f.a4;
j=j+1;
data(j)=f.b4;
j=j+1;
data(j)=f.c4;
j=j+1;
data(j)=f.a5;
j=j+1;
data(j)=f.b5;
j=j+1;
data(j)=f.c5;
j=j+1;
data(j)=f.a6;
j=j+1;
data(j)=f.b6;
j=j+1;
data(j)=f.c6;
j=j+1;
data(j)=f.a7;
j=j+1;
data(j)=f.b7;
j=j+1;
data(j)=f.c7;
j=j+1;
data(j)=f.a8;
j=j+1;
data(j)=f.b8;
j=j+1;
data(j)=f.c8;

% Dump Gaussian learned parameter files

save(strcat(Path1,Path3,'_Gauss_Param','.mat'),'data');

% index=index+1;
% 
% end
%%

plot(f,x,y,'b','r-');
ylim([-60 -35]);
xlabel('Frequency (in Hz)');
ylabel('Amplitude (in dB)');
hold on;
grid on;
ConvertPlot4Publication(strcat(Path1,Path3,'GF'), 'fontsize', 10, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.5,'pdf','off','eps','off','psfrag','off','fig','off');

