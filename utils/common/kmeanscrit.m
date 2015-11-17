function crit = kmeanscrit(partition,X)
%% —читаем критерий kmeans

% disp('K-means criterion calculating...');

[n,pnum]=size(partition);
crit = NaN(1,pnum);
% [n,v]=size(partition);

for i=1:pnum
    centr=[];
    ddist=[];
    labels=unique(partition(:,i));
    for k=1:length(labels)
        idx=find(partition(:,i)==labels(k));
        centr=mean(X(idx,:),1);
        centrm=repmat(centr,length(idx),1);
        ddist(k,:)=sum(sum(((X(idx,:)-centrm).*(X(idx,:)-centrm)),2));
    end
    crit(1,i)=sum(ddist);    
end


