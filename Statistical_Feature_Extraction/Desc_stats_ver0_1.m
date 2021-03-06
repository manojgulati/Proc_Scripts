% Descriptive statitics function for matlab 
function feature_vector = Desc_stats(data);
clc;
% clear all;

% Compute data vector on non-negative values of input data stream
data_vector = abs(data);
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
% 14. Entropy
% 15. Skewness
% 16. Kurtosis
% 17. Interquartile Range
% 18. Mean absolute deviation

% descriptive statistics function

mx = max(data_vector);
mn = min(data_vector);
mu = mean(data_vector);
sigma = std(data_vector);
mdn = median(data_vector);
mod = mode(data_vector);
vr = var(data_vector);
prc = prctile(data_vector,[10 25 75 90],1); 
prc1 = prc(1,1);
prc2 = prc(2,1);
prc3 = prc(3,1);
prc4 = prc(4,1);
range = mx-mn;
ent = entropy(data_vector);
skew = skewness(data_vector);
kurt = kurtosis(data_vector);
ir = iqr(data_vector);
mads = mad(data_vector);

% acf = autocorr(data_vector,[1]);
% l1 = norm(data_vector,1);
% l2 = norm(data_vector,2);
feature_vector = [mx; mn; mu; sigma; mdn; mod; vr; prc1; prc2; prc3; prc4; range; ent; skew; kurt; ir; mads;];
