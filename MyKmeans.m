function [ClusterIm, CCIm] = MyKmeans(Im, ImType, NumClusts)

% Kmeans Algorithm for RGB or Hyperspectral Image Clustering for Project 1 in CAP 6610 
% 
% Syntax: [ClusterIm, CCIm] = MyKmeans(Im, ImType, NumClusts)
% 
% Inputs:
%     Im - tensor of input image with dimension Row x Column x Channels
%     ImType - string argument (RGB or Hyper)
%     NumClusts - postive integer, number of clusters in the data
%     
% Outputs:
%     ClusterIm - double Mat - 2d array of labeled image with dimension Row x Column
%     CCIm - double Mat - tensor of binary image representing connected components in ClusterIm
%            not available for hyperspectral images
% 
% Author: Weihuang Xu
% University of Florida, Electrical and Computer Engineering

[nrows, ncols, nbands] = size(Im); 
ImInColumnFormat = reshape(Im, [], nbands); %reshape input image to column format

if strcmp(ImType, 'RGB')
        
    [ClusterLabel, ~] = kmeans(double(ImInColumnFormat), NumClusts, 'MaxIter', 1000); 
    ClusterIm = reshape(ClusterLabel, nrows, ncols);
    
    % find connected components in each cluster
    CCIm = zeros(NumClusts, nrows * ncols); 
    
    for label = 1:NumClusts
        idx = ClusterLabel == label;
        CCIm(label, :) = idx * 1;
    end
    
    CCIm = reshape(CCIm, NumClusts, nrows, ncols);
    
elseif strcmp(ImType, 'Hyper')
   
    [ClusterLabel, ~] = kmeans(double(ImInColumnFormat), NumClusts, 'MaxIter', 1000);
    ClusterIm = reshape(ClusterLabel, nrows, ncols); 
    CCIm = []; % the connected components are not required for hyperspectral images
end
end
    

