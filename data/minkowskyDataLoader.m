function [X, truth] = minkowskyDataLoader(Params)
% Function loads dataset indidated in Params.DatasetFileName
% Input:
% Params - struct with parameters
%
% Output:
% X - [object x feature] matrix
% truth - cluster labels

% loading
load([Params.Dir '/' Params.DatasetFileName]);

truth = y;
X = Data;