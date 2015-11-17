function [clustIncidence, DebugInfo] = linkClueSRSScheme(A, Params)
% This function performs LinkClue method with SRS similarity matrix and
% given linkage

if ~isfield(Params, 'Linkage')
    linkType = 'single';
else
    linkType = Params.Linkage;
end

if ~isfield(Params, 'K')
    K = ceil(sqrt(size(A,1)));
else
    K = Params.K;
end

d = stod(A); %convert similarity matrix to distance vector

% single linkage
Z = linkage(d, linkType);
clustIncidence = cluster(Z, 'maxclust', K);

DebugInfo.K = K;
DebugInfo.linkType = linkType;