% % Sequential feature Selection in Matlab ver0.1
% Manoj Gulati
% IIITD

clc;
clear all;

% Generate Labels
y = [zeros(500,1); ones(500,1)];
y = y(randperm(1000));
% Generate Dataset
x = rand(1000,99);
x(:,100) = y + rand(1000,1)*0.1;

xtrain = x(1:700, :); xtest = x(701:end, :);
ytrain = y(1:700); ytest = y(701:end);

% ypred = classify(xtest, xtrain, ytrain);
mdl = ClassificationKNN.fit(xtrain,ytrain);
[label(:,:),score,cost] = predict(mdl,xtest);
% sum(ytest ~= ypred)

% f = @(xtrain, ytrain, xtest, ytest) sum(ytest ~= classify(xtest, xtrain, ytrain));
% fs = sequentialfs(f,x,y)

