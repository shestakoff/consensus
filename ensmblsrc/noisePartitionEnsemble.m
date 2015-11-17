function labels = noisePartitionEnsemble(X, numRuns, Params)
% Function tries to worsen partition placed in X
% Input:
%   X - true partition to modify
%	numRuns - size of ensemble
%	Params - structure of parameters
%       * .prob - probability to rewire a label of object
%       * .type - type of label change ('perm' or 'random')
%
% Output:
%	labels - resulted

if(~isfield(Params,'type'))
    Params.type = 'random';
end

objNum = size(X,1);
clNum = length(unique(X));
clInit = [1:clNum];
labels = NaN(objNum, numRuns);
prob = Params.prob;

switch(Params.type)
    case 'perm'
        for irun = 1:numRuns
            labels(:, irun) = X;
            chProb = rand(objNum,1);
            idxChange = find(chProb <= prob);
            clPerm = randperm(clNum);
            while(~all(clPerm - clInit))
                clPerm = randperm(clNum);
            end
            labels(idxChange, irun) = clPerm(labels(idxChange, irun));
        end
        
    case 'random'
        for irun = 1:numRuns
            labels(:, irun) = X;
            chProb = rand(objNum,1);
            idxChange = find(chProb <= prob);
            clChange = randi(clNum, length(idxChange), 1);
            labels(idxChange, irun) = clChange;
        end
        
end