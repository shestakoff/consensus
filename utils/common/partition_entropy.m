function ent=partition_entropy(E)

[n,l]=size(E);
for j=1:l
    u=unique(E(:,j));

    ent(j)=0;
    for i=1:length(u)
        nk=sum(E(:,j)==u(i));
        ent(j)=ent(j)+(nk/n)*log2(nk/n);
    end
end
ent=-ent;