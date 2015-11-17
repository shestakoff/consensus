function [clustIncidence, DebugInfo] = RunBCEScheme(E, Params)
% Function performs calculation of Bayesian Consensus method
%
% Input:
% E - Base Labels
% Params - structure with parameters
%
% Output:
% clustIncidence - matrix of cluster belongings (objects x clusters)
% DebugInfo - struct with additional information on clustering result

DebugInfo = [];

% PramaLap:                 parameter for laplace smoothing
if isfield(Params, 'PramaLap')
    PramaLap = Params.PramaLap;
else
    PramaLap = 0.0001;
end
n = size(E, 1);
K = Params.K;

% If use random initialization
Palpha = rand(K, 1);
Palpha = Palpha./sum(Palpha);
Pbeta = cell(1, size(E,2));
number_baseclusterers = zeros(1,size(E, 2));
for j=1:size(E,2)
    
    number_baseclusterers(j) = length(unique(E(:,j)));
    
    clustId = unique(E(:,j));    
    clustProp = zeros(1,length(clustId));
    for k=1:length(clustId)
        clustProp(k) = sum(E(:,j)==clustId(k))./n;

%     for i=1:length(Pbeta)
%         temp=(size(Pbeta{i}));
%         [k,q]=size(temp);
%         temp=temp./(sum(temp,2)*ones(1,q));        
    end
    Pbeta{j} = drchrnd(clustProp, K);
end

% learn BCE 
[phiAll, gammaAll, resultAlpha, resultBeta] = learnBCE(E, Palpha, Pbeta, PramaLap, number_baseclusterers);


% Obtain the cluster assignments from BCE
clustIncidence = zeros(1,n);
for index=1:n
    wtheta(:,index) = gammaAll(:,index);
    bb = find(wtheta(:,index)==max(wtheta(:,index)));
    clustIncidence(index) = bb(1);
end

