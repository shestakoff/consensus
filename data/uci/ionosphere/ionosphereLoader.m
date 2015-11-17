function [X, truth] = ionosphereLoader(Params)
% Function loads ionosphere dataset and perform standardization of format
% Input:
% Params - struct with parameters
%
% Output:
% X - [object x feature] matrix
% truth - cluster labels

% loading

X = load([Params.Dir 'ionosphere.data']);

truth = X(:,end);
X(:,end) = [];
X(:,2) = [];
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
