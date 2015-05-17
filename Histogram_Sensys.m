clc;
clear all;
close all;
fontSize = 20;
% Plot histogram for KNN Data [CM, DM, CM+DM]
H = [75 100 100; 0 25 25; 0 25 25; 50 0 50; 25 25 25];
b=bar(H);
hold on;
set(gca,'Xtick',1:5,'XTickLabel',{'Laptop'; 'CFL'; 'LCD'; 'CPU';'BGND'})
title('Results from KNN Classification', 'FontSize', fontSize);
xlabel('Appliances', 'FontSize', fontSize);
ylabel('%age of True Positives', 'FontSize', fontSize);
l{1}='CM';l{2}='DM';l{3}='CM+DM';
legend(b,l,'FontSize', fontSize);
hold off;
saveas(gcf,'KNN_Hist','png');

% Plot histogram for SRC Data [CM, DM, CM+DM]
figure;
H = [75 100 100; 0 25 25; 25 25 25; 25 0 25; 0 25 25];
b=bar(H);
hold on;
set(gca,'Xtick',1:5,'XTickLabel',{'Laptop'; 'CFL'; 'LCD'; 'CPU';'BGND'})
title('Results from SRC Classification', 'FontSize', fontSize);
xlabel('Appliances', 'FontSize', fontSize);
ylabel('%age of True Positives', 'FontSize', fontSize);
l{1}='CM';l{2}='DM';l{3}='CM+DM';
legend(b,l,'FontSize', fontSize);
hold off;
saveas(gcf,'SRC_Hist','png');

% Plot histogram for KSVD Data [CM, DM, CM+DM]
figure;
H = [8.91 0 8.91; 61.38 0 61.38; 70.29 42 70.29; 22.77 0 22.77; 100 47 100];
b=bar(H);
hold on;
set(gca,'Xtick',1:5,'XTickLabel',{'Laptop'; 'CFL'; 'LCD'; 'CPU';'BGND'})
title('Results from KSVD Classification', 'FontSize', fontSize);
xlabel('Appliances', 'FontSize', fontSize);
ylabel('%age of True Positives', 'FontSize', fontSize);
l{1}='CM';l{2}='DM';l{3}='CM+DM';
legend(b,l,'FontSize', fontSize);
hold off;
saveas(gcf,'KSVD_Hist','png');



