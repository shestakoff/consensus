function labels = mwkmeansEnsamble(X, numRuns, Params)
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

[n, m] = size(X);

labels = NaN(n,numRuns);

k = Params.k;
Beta = Params.Beta;
InitialCentroids = Params.InitialCentroids;
InitialW = Params.InitialW;
p = Params.p;

maxTries = 10;

for irun = 1:numRuns
    
    iTry = 0;
    clustering = ones(size(X,1),1);
    while(length(unique(clustering)) ~= k && iTry <= maxTries)
        [clustering, ~, ~, ~, ~] = SubWkMeans(X, k, Beta, InitialCentroids, InitialW, p);
        iTry = iTry + 1;
    end
    labels(:,irun) = clustering;
end