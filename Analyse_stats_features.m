% % Load stats features extracted from EMI data 

clc;
clear all;

file_names = {'BGN_LC1','BGN_LC2','BGN_LC3','BGN_LC4','BGN_LC5','LC1','LC2','LC3','LC4','LC5','LCD1','LCD2','LCD3','LCD4','LCD5','CFL1','CFL2','CFL3','CFL4','CFL5','CPU1','CPU2','CPU3','CPU4','CPU5','PRT1','PRT2','PRT3','PRT4','PRT5'};
Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/TD16384_Features_SET3_CM/';
Path2 = 'FEAT150/';
for i=1:30
Temp = [];
        
    load(strcat(Path1,char(file_names(i)),'_TD_stat','.mat'));
    Temp = [Temp feature_vector(:,:)];
    eval(sprintf('X%d = Temp;',i));
end


%%
temp=[];
for j=1:30
    eval(sprintf('temp = [temp X%d(1,:)''];',j));
    set(gca,'FontSize', 18);
    boxplot(temp);
    grid on;
%     ylim([-0.0005 .1]);
%     ylabel('Amplitude (in Volts)')
    
end
%%
clc;
yticks = -0.00001:0.01:0.1;

dummy=[];
for j=1:30
    eval(sprintf('dummy = [dummy X%d(16,:)''];',j));     
end
% set(gca,'FontSize', 15);
boxplot(dummy);
% ax=gca; 
grid on; 
% ylim([-0.00001 30]);
set(gca,'YTick',yticks);
ylabel(' Inter-quartile Range (IQR)');
set(gca, 'XTick',1:30, 'XTickLabel',{'BGN1','BGN2','BGN3','BGN4','BGN5','LC1','LC2','LC3','LC4','LC5','LCD1','LCD2','LCD3','LCD4','LCD5','CFL1','CFL2','CFL3','CFL4','CFL5','CPU1','CPU2','CPU3','CPU4','CPU5','PRT1','PRT2','PRT3','PRT4','PRT5'})
rotateticklabel(gca,90);
% ax=gca;
% c=ax.XTickLabelRotation ;
% ax.XTickLabelRotation = 45;

ConvertPlot4Publication(strcat(Path1,'IQR_CM'),'height',3.5, 'width',6,'fontsize', 10, 'fontname', 'Times New Roman', 'samexaxes', 'on','linewidth',0.7,'keepheights','on','keepvertical','on','pdf','off','eps','off','psfrag','off','fig','off');

%%
temp=[];
for i=1:30
    eval(sprintf('temp = [temp X%d];',i));
end

temp = temp'; 
%%
csvwrite(strcat(Path1,'Stats_Features.csv'),temp);

%%

Data = temp';
