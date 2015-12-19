% Reduced descriptive statitics function for computing matlab 
function feature_vector = Desc_stats_ver0_2(data);
clc;
% clear all;

% data_vector = rand(100,1);
data_vector = data;
format long e;

% % Features
% 1. Mean -
% 2. Median -
% 3. Max -
% 4. Min -
% 5. Range (Max- Min)-
% 6. Autocorrelation (lag 1)-
% 7. Mode-
% 8. Standard deviation-
% 9. L1 norm-
% 10. L2 norm-
% 11. Sum of absolute difference
% 12. Percentile (10, 25, 75, 90)-
% 13. Variance-

% descriptive statistics function

mdn = median(data_vector);
prc = prctile(data_vector,[25 75],2); 
prc1 = prc(1,1);
prc2 = prc(1,2);
range = prc2 - prc1;
% acf = autocorr(data_vector,[1]);
% l1 = norm(data_vector,1);
% l2 = norm(data_vector,2);
feature_vector = [mdn; prc1; prc2; range;];
