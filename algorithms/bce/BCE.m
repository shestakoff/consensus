function [Ensemble_labels,Palpha] = BCE(true_labels,base_labels)
% load the data and initial model parameters
%
%   k = number of ensemble clusters
%   N = number of base clusterings
%   M = number of data points
%
% base_labels:              M*N, base clustering results to be processed
% Palpha:                   k*1, initial value for the model parameter of Dirichlet distribution
% Pbeta:                    cell with N elements for N base clusterings, each element is a
%                           k*q matrix, i.e., initial value for k parameters of a q-dimensional discrete distribution
% number_baseclusterers:    1*N, number of clusters in each of N base clustering results
% load Iris_clusterEnsemlbe_data.mat;

% PramaLap:                 parameter for laplace smoothing
PramaLap=0.000001 ;



[n N] = size(base_labels);

for i=1:N
    clustId=unique(base_labels(:,i));
    for j=1:length(clustId)
        base_labels(base_labels(:,i)==clustId(j),i)=j;
    end
end


% K=3;
% Palpha=[0.9; 0.05; 0.05];

% If use random initialization
% K=length(unique(true_labels));
% Palpha=rand(K,1);
% Palpha=Palpha./sum(Palpha);

% Another random initializatin
K=length(unique(true_labels));
b(1)=0;b(K+1)=1;
for i=2:K
    b(i)=rand;
end
b=sort(b);
for i=1:K
    Palpha(i)=b(i+1)-b(i);
end
Palpha=Palpha';

for j=1:size(base_labels,2)
    
    clustId=unique(base_labels(:,j));
    number_baseclusterers(j)=length(clustId);
    clustProp=zeros(1,length(clustId));
    for k=1:length(clustId)
        clustProp(k)=length(find(base_labels(:,j)==clustId(k)))./n;

%     for i=1:length(Pbeta)
%         temp=(size(Pbeta{i}));
%         [k,q]=size(temp);
%         temp=temp./(sum(temp,2)*ones(1,q));        
    end
    Pbeta{j}=drchrnd(clustProp,K);
end

% learn BCE 
[phiAll,gammaAll,resultAlpha,resultBeta]=learnBCE(base_labels,Palpha,Pbeta,PramaLap,number_baseclusterers);


% calculate accuracy
k=length(unique(true_labels));
M=size(gammaAll,2);

% Obtain the cluster assignments from BCE
Ensemble_labels=zeros(1,M);
for index=1:M
    wtheta(:,index)=gammaAll(:,index);
    bb=find(wtheta(:,index)==max(wtheta(:,index)));
    Ensemble_labels(index)=bb(1);
end

% Calculate the accuracy based on true labels and BCE results
% [accu]=calculateAccuracy(true_labels,Ensemble_labels);
% disp(['The micro-precision of BCE is ',num2str(accu)]);

end



