function x = gsamp(mu, covar, nsamp,rr)
%GSAMP  Sample from a Gaussian distribution.
%
%       Description
%
%       X = GSAMP(MU, COVAR, NSAMP) generates a sample of size NSAMP from a
%       D-dimensional Gaussian distribution. The Gaussian density has mean
%       vector MU and covariance matrix COVAR, and the matrix X has NSAMP
%       rows in which each row represents a D-dimensional sample vector.
%
%       See also
%       GAUSS, DEMGAUSS
%

%       Copyright (c) Ian T Nabney (1996-9)

d = size(covar, 1);

mu = reshape(mu, 1, d);   % Ensure that mu is a row vector

[evec, eval] = eig(covar);

coeffs = randn(nsamp, d)*sqrt(eval);
%rr=5+rand*5;
x = ones(nsamp, 1)*mu*rr + coeffs*evec';