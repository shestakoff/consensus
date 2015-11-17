function labels = hieraricalEnsamble(X, numRuns, Params)
% Function performs simple batch kmeans and saves results in labels
% Input: 
% X - [object x feature] matrix
% numRuns - number of runs of the procedure
% Params - structure with parameters
%   * 'metric' - distance measure metric to compute distances between the rows of X
%   * 'method' - how to measure the distance between clusters
%   * 'maxclust' - max amount of produced clusters
%
% Output:
% labels - results over runs of kmeans


objNum = size(X,1);
labels = NaN(objNum, numRuns);
maxclust = Params.maxclust;
method = Params.method;
metric = Params.metric;


if numRuns ~= length(maxclust)
   maxclust = [maxclust, repmat(maxclust(1), numRuns-length(maxclust) , 1)]; 
end

irun = 1;

while(irun <= numRuns)
    Z = linkage(X, method, metric);
    labels(:,irun) = cluster(Z,'maxclust', maxclust(irun));
    irun = irun+1;
end

