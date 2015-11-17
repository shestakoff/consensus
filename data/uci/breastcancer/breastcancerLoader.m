function [X, truth] = breastcancerLoader(Params)
% Function loads breastcancer dataset and perform standardization of format
% Input:
% Params - struct with parameters
%
% Output:
% X - [object x feature] matrix
% truth - cluster labels

% loading
[~, ~, raw] = xlsread([Params.Dir 'wdbc.csv'],'wdbc','C1:AG569');
           
X = cell2mat(raw);

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
