function labels = mwkmeansGetLabels(X, numRuns, Params)
% Function performs simple batch kmeans and saves results in labels
% Input:
% X - [object x feature] matrix
% numRuns - number of runs of the procedure
% Params - structure with parameters
%   * k - number of clusters
%   * Beta - same as p
%   * InitialCentroids - false 
%   * InitialW - false
%   * p - exponent in the metrics
%
% Output:
% labels - results over runs of kmeans

labels = X;