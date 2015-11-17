function FusionConsensus=ft(E)

%% Fusion-Transfer
% Slowest Algorithm.. Probably because of silly programming..
% 2 steps: Fusion и Transfer.
% Fusion procedure:
% Find pair i j that maximises W(i,j). Join i j in a single class Xk
% and recalculate W 
% Continue, until criterion S rises
% Transfer procedure:
% For each class and for each object calc weight of the object
% (K(i,k)=sum(W(i,Xk)) for all objects in Xk
% Until there is an object for each its weight in his class is not maxiamal
% do:
% Put this object in class where its weight is maximal, if this weight is
% less put it in separated class
% Update K
% Input: Consensus matrix

[A] = BuildEnsembleFormats(E);

l = size(E,2);

n=size(A,1);

A=2*(A-l/2);
A=A-diag(diag(A));
w=A;
clusters=zeros(n,n+1);
clusters(:,1)=1:n;
S=0;
S_prev=0;

% Fusion Proc
while(1)

    [temp, I] = max(w,[],1);
    [~, J] = max(temp,[],2);
    
    jj=J;
    ii=I(jj);
    
    
    if ii==jj % Если положительных элементов в матрице не осталось
%         clustersnum=clustersnum-1;
        break;
    end
    
    clusters(ii,1:size(unique([clusters(ii,:),clusters(jj,:)]),2))=unique([clusters(ii,:),clusters(jj,:)]);
    clusters(jj,1:size(unique([clusters(ii,:),clusters(jj,:)]),2))=unique([clusters(ii,:),clusters(jj,:)]);
    
    clustersnum=size(clusters,1);
%     w=zeros(size(w));
    
    for i=1:clustersnum % для каждого класса..
        idx=unique(clusters(i,:));
        idx(:,1)=[];
        idx2=unique(clusters(jj,:));
        idx2(:,1)=[];
        score=0;
        classlabels=E(idx,:);
        curlabels=E(idx2,:);
        for t=1:l
            if length(union(classlabels(:,t),curlabels(:,t)))==1 % Если объединения объектов не в одном класса по разбиению
                score=score+1;
            end
        end
        
        w(i,jj)=score;
    end
    w(:,jj)=2*(w(:,jj)-l/2);
    w(jj,:)=w(:,jj)';
            
    w(ii,:)=[];
    w(:,ii)=[];
    clusters(ii,:)=[];
    
    w=w-diag(diag(w));
    
    for i=1:clustersnum-1
        idx=unique(clusters(i,:));
        idx(:,1)=[];
        for x=1:length(idx)
            for y=1:length(idx)
                S=S+A(idx(x),idx(y))/2;
            end
        end
    end
    
    if(S>S_prev)
        S_prev=S;
        S=0;
    else        
        break;
    end
    
end
         

for i=1:size(clusters,1);
    clusters(i,1:size(unique(clusters(i,:)),2))=unique(clusters(i,:));
end

% Transfer Proc
FusionConsensus=zeros(1,n);
while(1)
    clustersnum=size(clusters,1);

    flag=1; 
    K=zeros(n,clustersnum);
    for t=1:clustersnum % cоставляем вклады объектов в классы 
        idx=unique(clusters(t,:));
        idx(:,1)=[];
        for i=1:n
            K(i,t)=sum(A(i,idx));
        end
    end

    [~, WeightClusters] = sort(K,2,'descend');

    WMaxCluster=WeightClusters(:,1);
    for i=1:size(WMaxCluster,1)
        if(~ismember(i,clusters(WMaxCluster(i),:))) % Если максимальное значение не из того класа, в котором объект
            flag=0;
            for j=1:clustersnum
                clusters(j,clusters(j,:)==i)=0;
            end
            if K(i,WMaxCluster(i))>=0
                clusters(WMaxCluster(i),1)=i;
                clusters(WMaxCluster(i),1:size(unique(clusters(WMaxCluster(i),:)),2))=unique(clusters(WMaxCluster(i),:));
                break;
            else
                clusters(clustersnum+1,2)=i; % создаём отдельный класс
                break
            end
        end
    end
    
    for i=1:size(clusters,1)
        idx=[];
        if(length(unique(clusters(i,:)))==1)
            idx=[idx, i];
        end
    end
    if(~isempty(idx))
        clusters(idx,:)=[];
    end

    if(flag==1)
        for t=1:size(clusters,1)
            idx=unique(clusters(t,:));
            idx(:,1)=[];
            FusionConsensus(idx(1,:))=t;
        end
        break;
    end
 end
     
FusionConsensus=FusionConsensus';

end