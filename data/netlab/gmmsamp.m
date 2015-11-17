function [data,label] = gmmsamp(mix, n, choice)
%GMMSAMP Sample from a Gaussian mixture distribution.
%
%	Description
%
%	DATA = GSAMP(MIX, N) generates a sample of size N from a Gaussian
%	mixture distribution defined by the MIX data structure. The matrix X
%	has N rows in which each row represents a MIX.NIN-dimensional sample
%	vector.
%
%	[DATA, LABEL] = GMMSAMP(MIX, N) also returns a column vector of
%	classes (as an index 1..N) LABEL.
%
%	See also
%	GSAMP, GMM
%

%	Copyright (c) Ian T Nabney (1996-9)

% Check input arguments
errstring = consist(mix, 'gmm');
if ~isempty(errstring)
  error(errstring);
end
if n < 1
  error('Number of data points must be positive')
end

% Determine number to sample from each component
priors = rand(1, n);

% Pre-allocate data array
data = zeros(n, mix.nin);
if nargout > 1
  label = zeros(n, 1);
end
cum_prior = 0;		% Cumulative sum of priors
total_samples = 0;	% Cumulative sum of number of sampled points
for i = 1:mix.ncentres
  num_samples = sum(priors >= cum_prior & ...
    priors < cum_prior + mix.priors(i));
  % Form a full covariance matrix
  switch mix.covar_type
    case 'spherical'
      covar = mix.covars(i) * eye(mix.nin);
      rr=5+rand*15;
      covar=0.8*1*covar*rr;
    case 'diag'
      covar = diag(mix.covars(i,:));
    case 'full'
      covar = mix.covars(:,:,i);
    case 'ppca'
      covar = mix.covars(i) * eye(mix.nin) + ...
      mix.U(:, :, i)*diag(mix.lambda(i,:))*(mix.U(:, :, i)');
      rr=5+rand*15;
      if choice==1
          covar=0.8*i*covar*rr;
      elseif choice==2
          covar=0.8*i.^2*covar*rr;
      elseif choice==3
          covar=0.8*2*covar*rr;
      elseif choice==4
          covar=0.8*1*covar*rr;
      end
      %covar=mix.U(:, :, i)*diag(mix.lambda(i,:))*(mix.U(:, :, i)')
otherwise
      error(['Unknown covariance type ', mix.covar_type]);
  end
  data(total_samples+1:total_samples+num_samples, :) = ...
    gsampito(mix.centres(i,:), covar, num_samples,rr);
  if nargout > 1
    label(total_samples+1:total_samples+num_samples) = i;
  end
  cum_prior = cum_prior + mix.priors(i);
  total_samples = total_samples + num_samples;
end
