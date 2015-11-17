function [X, truth] = generatedLoader(Params)
% Function performs data generation of gaussian mixtures according to netlab gmm
% Input:
% Params - struct with parameters
%
% Output:
% X - [object x feature] matrix
% truth - cluster labels

numFeatures = Params.numFeatures; % number of features
numClusters = Params.numClusters; % number of clusters
numObjects = Params.numObjects; % number of objects
clustCardinalities = Params.clustCardinalities; % cluster coordinalitires, can be either string of vector of coordonalities
% possible values 'eq', 'rand' and vector of coordinalities
sigma = Params.Sigma; % sigma of cluster spread
sigmaShift = Params.SigmaShift; % shift for sigma
discen = Params.Discenter; % factor for cluster center position
covarType = Params.CovarType; % type of covariance matrix


mix = gmm(numFeatures, numClusters, covarType,...
        1, numObjects, clustCardinalities,...
        sigma, sigmaShift, discen);

[X, truth]=gmmsamp_ori(mix, numObjects);