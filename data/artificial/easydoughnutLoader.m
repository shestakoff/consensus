function [X, truth] = easydoughnutLoader(Params)
% Function loads easydoughnu dataset and perform standardization of format
% Input:
% Params - struct with parameters
%
% Output:
% X - [object x feature] matrix
% truth - cluster labels

% loading

X = load([Params.Dir 'easy_doughnut.txt']);

[n,v] = size(X);

truth = ones(n,1);
truth(51:100) = 2;

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
