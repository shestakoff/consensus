function labels = kmeansEnsamble(X, numRuns, Params)
% Function performs simple batch kmeans and saves results in labels
% Input:
% X - [object x feature] matrix
% numRuns - number of runs of the procedure
% Params - structure with parameters
%   * kmin, kmax - min-max amount of produced clusters
%
% Output:
% labels - results over runs of kmeans

objNum = size(X,1);
labels = NaN(objNum, numRuns);
kmin = Params.kmin;
if ~isinf(Params.kmax)
    kmax = Params.kmax;
else
    kmax = round(sqrt(objNum));
end

irun = 1;
errIter = 0;
k = randi([kmin kmax],numRuns,1);
while(irun <= numRuns)
    % in case we get error with empty cluster maaaany times
    %     if(errIter > 10)
    %        k(irun) = k(irun)-1;
    %        errIter = 0;
    %     end
    
    %     try
    labels(:,irun) = kmeans(X, k(irun), 'emptyaction','drop');
    %     catch err
    %         % in case we get an error with empty cluster
    %         if(strcmp(err.identifier, 'stats:kmeans:EmptyCluster'))
    %            errIter = errIter+1;
    %            continue;
    %         end
    %     end
    irun = irun+1;
end

