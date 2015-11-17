function [attr, av_crit, semi_av_crit, sum_crit] = CalcClusterPower_diag(A, idx)
% Function returns 
% - attration of each object to cluser S, 
% - value of average within similarity
% - value of semi-average within similarity
% - value of summary within similarity
%
% Cluster S is defined by index vector <idx>

n = size(A,1);
n_clust = length(idx);

sum_crit = sum(sum(A(idx,idx))); 
av_crit = sum_crit./(n_clust*n_clust);
semi_av_crit = av_crit * (n_clust);

attr = zeros(n,1);

attr = sum(A(:,idx),2);
attr = attr./n_clust;

attr = attr - av_crit./2;