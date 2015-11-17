function [A, P, Inc, C, S, AS] = BuildEnsembleFormatsFixed(E)
% Function build matrices A,P from a given ensemble and Incidence format of
% ensemble
% Input:
% E - ensemble of partitions
%
% Output:
% A - consensus matrix, where A(i,j) = ratio of parttions in ensamble,
% where objects i and j are in the same cluster
% P - matrix, where P(i,j) = sum of inverted cordinalities of clusters, in
% which i and j are joined
% Inc - incidence format of ensemble E

% [18.01.2015]
% Adding Connected-Triple Based Similarity matrix

[n,l]=size(E);

% CTS
dc = 0.8;
C = cts(E, dc);

% % SRS
S = [];
% dc = 0.8;
R = 5;
S = srs(E, dc, R);

% % ASRS
AS = [];
% dc = 0.8;
% AS = asrs(E, dc);


indCol = zeros(1, l+1);
for ip = 1:l
    indCol(ip+1) = length(unique(E(:,ip)));
end

indCol = cumsum(indCol);

Inc = sparse(n, indCol(end));
P=sparse(n,n);
for ip=1:l
    lbl=unique(E(:,ip));
    for j=1:n
        Inc(j, indCol(ip)+1:indCol(ip+1)) = (lbl == E(j,ip));
    end
    p = Inc(:, indCol(ip)+1:indCol(ip+1))' * Inc(:, indCol(ip)+1:indCol(ip+1));
    p(p>0) = p(p>0).^(-1);
    
    P=P+Inc(:, indCol(ip)+1:indCol(ip+1))*p*Inc(:, indCol(ip)+1:indCol(ip+1))';
end

A=Inc*Inc';

end