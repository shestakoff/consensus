function [X, truth] = heartLoader(Params)
% Function loads heart dataset and perform standardization of format
% Input:
% Params - struct with parameters
%
% Output:
% X - [object x feature] matrix
% truth - cluster labels

% loading

X = load([Params.Dir 'heart.dat']);

truth = X(:,end);
[truth, idx] = sort(truth);
X(:,end) = [];
X = X(idx,:);
[n,v] = size(X);

% Replace categorical features
catFeatures = [3, 7, 11, 13];
catSizes = NaN(length(catFeatures),1);
catIdx = NaN(length(catFeatures)+1,1);
contFeatures = setdiff(1:v, catFeatures);
Xtemp = X(:, contFeatures);

for ifeat = 1:length(catFeatures)
    [uVals, ~, idxVals] = unique(X(:, catFeatures(ifeat)));
    catSizes(ifeat) = length(uVals);
    catIdx(ifeat) = size(Xtemp,2)+1; 
    
    M = zeros(n, length(uVals));
    idx = sub2ind(size(M), (1:n)', idxVals);
    M(idx) = 1;
    Xtemp = [Xtemp, M];       
end

catIdx(end) = size(Xtemp,2)+1; 
X = Xtemp;

%% Feature Standartization

% Centering
if(isfield(Params,'Centering') && Params.Centering)
    me = mean(X);
    X = X - repmat(me, n, 1);
end

% Normalization
if(isfield(Params,'Normalization') && Params.Normalization)
    st = std(X(:, 1:length(contFeatures)));
    X(:, 1:length(contFeatures)) = X(:, 1:length(contFeatures))./repmat(st, n, 1);
    
    for ifeat = 1:length(catFeatures)
        X(:,catIdx(ifeat):catIdx(ifeat+1)-1) = X(:,catIdx(ifeat):catIdx(ifeat+1)-1)./sqrt(catSizes(ifeat));
    end    
end