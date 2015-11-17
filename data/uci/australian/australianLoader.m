function [X, truth] = australianLoader(Params)
% Function loads australian dataset and perform standardization of format
% Input:
% Params - struct with parameters
%
% Output:
% X - [object x feature] matrix
% truth - cluster labels

% Dataset description
%
% A1:	0,1    CATEGORICAL
%         a,b
%     A2:	continuous.
%     A3:	continuous.
%     A4:	1,2,3         CATEGORICAL
%         p,g,gg
%     A5:  1, 2,3,4,5, 6,7,8,9,10,11,12,13,14    CATEGORICAL
%          ff,d,i,k,j,aa,m,c,w, e, q, r,cc, x 
%          
%     A6:	 1, 2,3, 4,5,6,7,8,9    CATEGORICAL
%         ff,dd,j,bb,v,n,o,h,z 
% 
%     A7:	continuous.
%     A8:	1, 0       CATEGORICAL
%         t, f.
%     A9: 1, 0	    CATEGORICAL
%         t, f.
%     A10:	continuous.
%     A11:  1, 0	    CATEGORICAL
%           t, f.
%     A12:    1, 2, 3    CATEGORICAL
%             s, g, p 
%     A13:	continuous.
%     A14:	continuous.


% loading
X = load([Params.Dir 'australian.dat']);

truth = X(:,end);
truth = truth + 1;
X(:,end) = [];
[n,v] = size(X);

% Replace categorical features
catFeatures = [1, 4, 5, 6, 8, 9, 11, 12];
catSizes = NaN(length(catFeatures),1);
catIdx = NaN(length(catFeatures)+1,1);
contFeatures = setdiff(1:v, catFeatures);
Xtemp = X(:, contFeatures);

for ifeat = 1:length(catFeatures)
    [uVals, ~, idxVals] = unique(X(:, catFeatures(ifeat)));
    catSizes(ifeat) = length(uVals);
    catIdx(ifeat) = size(Xtemp,2)+1; 
    
    M = zeros(n, length(uVals));
    idx = sub2ind(size(M), (1:n)', idxVals);
    M(idx) = 1;
    Xtemp = [Xtemp, M];       
end

catIdx(end) = size(Xtemp,2)+1; 
X = Xtemp;

%% Feature Standartization

% Centering
if(isfield(Params,'Centering') && Params.Centering)
    me = mean(X);
    X = X - repmat(me, n, 1);
end

% Normalization
if(isfield(Params,'Normalization') && Params.Normalization)
    st = std(X(:, 1:length(contFeatures)));
    X(:, 1:length(contFeatures)) = X(:, 1:length(contFeatures))./repmat(st, n, 1);
    
    for ifeat = 1:length(catFeatures)
        X(:,catIdx(ifeat):catIdx(ifeat+1)-1) = X(:,catIdx(ifeat):catIdx(ifeat+1)-1)./sqrt(catSizes(ifeat));
    end    
end
