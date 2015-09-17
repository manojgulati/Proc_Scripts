% Snippet to test for centroid based technique

clear all;
clc;

data1 = rand(15,10);

cent = median(data1');
% cent1 = cent1';
cent = cent';
centroid=[];

for index=(1:15)
    centroid(index) = median(data1(index,:));
end
centroid = centroid';
    
    
    
    
    