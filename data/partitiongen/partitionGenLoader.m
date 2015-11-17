function [X, truth] = partitionGenLoader(Params)
% Function generates partiton on N objects.
% Input:
% Params - struct of parameters:
%   * .numObjects - number of objects to generate
%   * .numClusters - number of clusters
%   * .minObjects - minimum number of objects in each cluster
% 
% Output:
%   * X - truth partition (placed also here to generate ensemble)
%   * truth - truth partition

% Initialization of params
N = Params.numObjects;
k = Params.numClusters;
m = Params.minObjects;

% Initialization of output
truth = NaN(N,1);
X = [];

if(N < k*m)
    m = floor(N./k);
end
n = N - k*m;

% Vector of probabilities
p = NaN(k+1,1);
p(2:end-1) = rand(k-1,1);
p(2:end-1) = sort(p(2:end-1));
p(1) = 0;
p(end) = 1;

% Labeling
idx = 0;
for i = 2:k
    ClNum = round((p(i) - p(i-1))*n) + m;
    truth(idx + 1 : idx + ClNum) = i-1;
    idx = idx + ClNum;
end

truth(idx + 1:end) = k;
X = truth;
