function [X, truth] = balanceLoader(Params)
% Function loads balance dataset and perform standardization of format
% Input:
% Params - struct with parameters
%
% Output:
% X - [object x feature] matrix
% truth - cluster labels

% Attribute Information:
% 	1. Class Name: 3 (L, B, R)
% 	2. Left-Weight: 5 (1, 2, 3, 4, 5)
% 	3. Left-Distance: 5 (1, 2, 3, 4, 5)
% 	4. Right-Weight: 5 (1, 2, 3, 4, 5)
% 	5. Right-Distance: 5 (1, 2, 3, 4, 5)


% loading
X = load([Params.Dir 'balance.data']);

truth = X(:,1);
X(:,1) = [];
[n,v] = size(X);

% Replace categorical features
catFeatures = [1:4];
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