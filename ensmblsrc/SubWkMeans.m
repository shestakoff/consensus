function [U, W, Z, UDistToZ, LoopCount] = SubWkMeans (Data, k, Beta, InitialCentroids, InitialW, p)
%From:
%Amorim, R.C. and Mirkin, B., Minkowski Metric, Feature Weighting and Anomalous Cluster Initialisation in K-Means Clustering, 
%Pattern Recognition, vol. 45(3), pp. 1061-1075, 2012.
%
%Parameters:
%Data
%      Dataset, format: Entities x Features
%k
%      Total number of clusters in the dataset
%Beta 
%      Weight Exponent
%Initial Centroids (optional)
%      Initial centroids the algorithm should use, format: k x Features. 
%      Optional, if you don't want to use it just write false.
%InitialW (Optional)
%      Initial set of weights the algorithm should use, format: k x
%      Features. Optional, write false if you don't want to use it.
%p
%      Distance Exponent.
%
%REMARKS
%      If you want to use the MWK-Means as in the paper, the value of Beta
%      and p should be the same.
%
%Outputs
%
%U
%      Cluster Labels. Clearly they may not directly match the dataset
%      labels (you should use a confusion matrix).
%W
%      Final Weights
%Z
%      Final Centroids
%UDistToZ
%      The distance of each entity to its centroid.
%LoopCount
%      The number of loops the algorithm took to converge. The maximum is
%      hard-coded to 500 (variable MaxLoops)

%M Lines and N Columns
[M,N] = size(Data);
MaxLoops = 500;

%Binary Variable M x k, cluster label
U = zeros(M, 1);
OldU = U;

% Step 1
%Get Random Initial Centroids (VALUES) X Number of K
if exist('InitialCentroids','var') && InitialCentroids(1,1)~=false
    Z = InitialCentroids;
else
    rand('twister', sum(100*clock));
    Z=Data(randperm(M)<=k,:);
end

%Generate Initial set of weights FIXED
if exist('InitialW','var') && InitialW(1,1) ~=false
    W = InitialW;
else
    %W = repmat(1/N, k, N);
    W(1:k,1:N)=1/N;
end

if ~exist('p','var'), p = 'f'; end

LoopCount = 0;
while true
    %Step 2
    %Find Initial U that is minimized for the initials Z and W
    [NewUtp1 UDistToZ]= GetNewU (Data, Z, W.^Beta, p,M);
    %If there is no alteration in the labels stop
    if NewUtp1 == U, break, end;
    
    %if the labes are equal to the previous-previous lables - stop (cycle)
    if NewUtp1 == OldU, break; end;
    
    %Step 3
    OldU = U;
    U = NewUtp1;
    %Get New Centroids
    Ztp1 = GetNewZ(Data, U, k,p, Z);
    %If there is no alteration in the centroids stop
    if Ztp1==Z , break, end;
    
    Z = Ztp1;
    %Step 4
    %Update the Weights
    Wtp1 = GetNewW(Data, U, Z, Beta,p,N);
    %if there is no alteration in the weights, stop
    if Wtp1 == W & LoopCount > 20, break; end;
   W = Wtp1;
   LoopCount = LoopCount + 1;
   if LoopCount>=MaxLoops, break; end;
end




function r=dist(a,b,w,p)
%w here is already w.^Beta
switch (nargin)
    case 2
        %the below is fine, in this case b is a scalar
        r = sum(sum((a - b).^2));
    case 3
        r = sum(sum(((a - b).^2).*w,2),2);
    case 4
        if p =='f'
            r = sum(sum(((a - b).^2).*w));
        end
        
end


function [U UDistToZ]= GetNewU (Data, Z, W, p, M)
Size_Z=size(Z,1);
temp=zeros(M,Size_Z);
OnesIndex(1:M,1)=1;
%for each Centroid, gets temp , line = entity, col = cluster
for c = 1 : Size_Z
    tmp_Z=Z(c,:);
    tmp_W=W(c,:);
    if p=='f'
        temp(:,c) = dist(Data, tmp_Z(OnesIndex,:), tmp_W(OnesIndex,:));
    else
        temp(:,c) = MinkDist(Data, tmp_Z(OnesIndex,:), p, W(c,:),OnesIndex);
    end
end
%[UDistToZ2 b2]=min(temp');
%U=b';
[UDistToZ, U]=min(temp,[],2);


function Z = GetNewZ(Data, U, k,p, OldZ)
Z = OldZ;
if p == 'f'
    for l = 1 : k
        Z(l,:) = mean(Data(U==l,:));
    end
else
    for l = 1 : k
        if sum(U==l)>1
            %if there isnt any entity in the cluster - dont change the Z
            Z(l,:)=New_cmt(Data(U==l,:),p);
        end
    end
end

function W = GetNewW(Data, U, Z, Beta,p,N)
k = size(Z,1);
%N = size(Data,2);
D = zeros(k,N);
%W = zeros(k,N);
W=D;

for l = 1 : k
    for j = 1 : N 
         if p=='f'
            D(l,j) = dist(Data(U==l,j), Z(l,j));  
         else
            D(l,j) = sum(abs(Data(U==l,j)- Z(l,j)).^p);
         end
    end
    
end
D = D + mean(mean(D));


%Calculate the actual Weight
if Beta~=1
    exp = 1/(Beta-1);
    for l = 1 : k
        for j = 1 : N
            tmpD=D(l,j);
            W(l,j)= 1/sum((tmpD(1,ones(N,1))./D(l,:)).^exp);
        end
    end
else
    for l = 1 : k
        [~, MinIndex] = min(D(l,:));
        W(l,MinIndex)=1;
    end
end 

function r= MinkDist(x, y, p, w,OnesIndex)
%calculates the  Minkowski distance in between x and y
r = sum((abs(x - y).^p).*w(OnesIndex,:),2).^(1/p);




