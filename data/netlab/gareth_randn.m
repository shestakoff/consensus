function [data,label,prior,center]=gareth_randn(v,k,rows,discen)
elsize=randperm(k);
%-----------uniformally random priors-----------%
b(1)=0;b(k+1)=1;
for i=2:k
    b(i)=rand;
end
b=sort(b);
for i=1:k
    prior(i)=b(i+1)-b(i);
end
k_dis=round(prior*rows);
for i=1:k
    if k_dis(i)==0
        k_dis(i)=k_dis(i)+15;
        ink=find(k_dis==max(k_dis));
        k_dis(ink)=k_dis(ink)-15;
        prior=k_dis/rows;
    elseif k_dis(i)<15
        ink=find(k_dis==max(k_dis));
        k_dis(ink)=k_dis(ink)-(15-k_dis(i));
        k_dis(i)=k_dis(i)+(15-k_dis(i));
        prior=k_dis/rows;
    end
end
label=[];
for i=1:k
    tmp=i*ones(1,k_dis(i));
    label=[label,tmp];
end

first=[1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1];
cent(1,:)=first(1:v);
for i=2:k
    cent(i,:)=cent(1,randperm(v));
end
cent=cent*discen;
data=[];
for i=1:k
    data=[data;repmat(cent(i,:),k_dis(i),1)];
end
[R,C]=size(data);
data=data+rand(R,C);

centredata=data;
for i=1:k
    if k_dis(i)==1
        center(i,:)=centredata(1,:);
        centredata(1,:)=[];
    else
        center(i,:)=sum(centredata(1:k_dis(i),:))/k_dis(i);
        centredata(1:k_dis(i),:)=[];
    end
end