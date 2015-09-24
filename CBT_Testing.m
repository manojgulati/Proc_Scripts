% Snippet to test for centroid based technique

clear all;
clc;

data1 = rand(15,10);

cent = mean(data1,2);
% cent1 = cent1';
cent = cent';
centroid=[];

for index=(1:15)
    centroid(index) = mean(data1(index,:));
end
% centroid = centroid';
    
    
    
    
    