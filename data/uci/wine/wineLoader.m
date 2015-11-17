function [X, truth] = wineLoader(Params)
% Function loads wine dataset and perform standardization of format
% Input:
% Params - struct with parameters
%
% Output:
% X - [object x feature] matrix
% truth - cluster labels

% loading

X = load([Params.Dir 'wine.data']);

truth = X(:,1);
X(:,1) = [];
[n,v] = size(X);

%% Feature Standartization

% Centering
if(isfield(Params,'Centering') && Params.Centering)
    me = mean(X);
    X = X - repmat(me, n, 1);
end

% Normalization
if(isfield(Params,'Normalization') && Params.Normalization)
    st = std(X);
    X = X./repmat(st, n, 1);
end
