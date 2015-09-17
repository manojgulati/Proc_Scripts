% % Load stats features extracted from EMI data 

clc;
clear all;

file_names = {'BGN_LC1','BGN_LC2','BGN_LC3','BGN_LC4','BGN_LC5','LC1','LC2','LC3','LC4','LC5','LCD1','LCD2','LCD3','LCD4','LCD5','CFL1','CFL2','CFL3','CFL4','CFL5','CPU1','CPU2','CPU3','CPU4','CPU5','PRT1','PRT2','PRT3','PRT4','PRT5'};
Path1 = '/Users/manojgulati/Documents/Algo_Testing_Data/30_March_2015/TD16384_Features_SET3_DM/compressed_features/';
Path2 = 'FEAT150/';
for i=1:30
Temp = [];
    for dim = 1:10
        
        load(strcat(Path1,Path2,char(file_names(i)),'_TD_stat_',int2str(dim),'.mat'));
%         Analyzing one sub-feature i.e. Median at a time
        Temp = [Temp feature(:,4)];
    end
    eval(sprintf('X%d = Temp;',i));
end


%%
dummy=[];
for j=1:30
    eval(sprintf('dummy = [dummy X%d(13,:)''];',j));
    set(gca,'FontSize', 18);
    boxplot(dummy);
    grid on;
%     ylim([-0.00001 0.005]);
%     ylabel('Amplitude (in Volts)')
    
end

%%
temp_var=[];
for i=1:30
    eval(sprintf('temp_var = [temp_var X%d];',i));
end

temp_var = temp_var'; 
%%
csvwrite(strcat(Path1,'Stats_Features.csv'),temp);

%%

Data = temp';
