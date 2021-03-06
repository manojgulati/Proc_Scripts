% % Learn Kmeans classifier
clc;
clear all;


No_of_traces = 3;
feat_dim = 15;
% Test Dataset
data = [ones(feat_dim,1)'; 2*ones(feat_dim,1)'; 3*ones(feat_dim,1)'; 4*ones(feat_dim,1)'; 5*ones(feat_dim,1)'; 6*ones(feat_dim,1)';];

% Train Classifier
rng(1); % Initialise random number generator for reproducibility
[idx,c] = kmeans(data,6,'start','uniform', 'emptyaction','singleton');
%%
x = [];
Z1=zeros(6,1);
Z2=zeros(6,1);
Z3=zeros(6,1);
Z4=zeros(6,1);
Z5=zeros(6,1);
Z6=zeros(6,1);
% Infer the label for test data of AUT1
Xnew = [ones(feat_dim,1)'; 2*ones(feat_dim,1)'; 3*ones(feat_dim,1)';];
for i=(1:No_of_traces)
    for app_index = 1:6
        x(app_index) = norm((Xnew(i,:)-c(app_index,:)),2);
    end
    [M,I] = min(x);
    Z1(I)=1;    
end

% Infer the label for test data of AUT1
Xnew = [ones(feat_dim,1)'; 2*ones(feat_dim,1)'; 3*ones(feat_dim,1)';];
for i=(1:No_of_traces)
    for app_index = 1:6
        x(app_index) = norm((Xnew(i,:)-c(app_index,:)),2);
    end
    [M,I] = min(x);
    Z2(I)=1;    
end

% Infer the label for test data of AUT1
Xnew = [ones(feat_dim,1)'; 2*ones(feat_dim,1)'; 3*ones(feat_dim,1)';];
for i=(1:No_of_traces)
    for app_index = 1:6
        x(app_index) = norm((Xnew(i,:)-c(app_index,:)),2);
    end
    [M,I] = min(x);
    Z3(I)=1;    
end

% Infer the label for test data of AUT1
Xnew = [ones(feat_dim,1)'; 2*ones(feat_dim,1)'; 3*ones(feat_dim,1)';];
for i=(1:No_of_traces)
    for app_index = 1:6
        x(app_index) = norm((Xnew(i,:)-c(app_index,:)),2);
    end
    [M,I] = min(x);
    Z4(I)=1;    
end

% Infer the label for test data of AUT1
Xnew = [ones(feat_dim,1)'; 2*ones(feat_dim,1)'; 3*ones(feat_dim,1)';];
for i=(1:No_of_traces)
    for app_index = 1:6
        x(app_index) = norm((Xnew(i,:)-c(app_index,:)),2);
    end
    [M,I] = min(x);
    Z5(I)=1;    
end

% Infer the label for test data of AUT1
Xnew = [ones(feat_dim,1)'; 2*ones(feat_dim,1)'; 3*ones(feat_dim,1)';];
for i=(1:No_of_traces)
    for app_index = 1:6
        x(app_index) = norm((Xnew(i,:)-c(app_index,:)),2);
    end
    [M,I] = min(x);
    Z6(I)=1;    
end

Z = [Z1'; Z2'; Z3'; Z4'; Z5'; Z6';];

