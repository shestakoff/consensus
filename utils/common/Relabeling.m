function E_relabel =  Relabeling(E, Ref)

% Ref=E(1,:); % выбираем ссылку
E_relabel(:,1)=Ref;

[n,l]=size(E);
k=size(unique(Ref),1);

for i=1:l
    CrTbl=crosstab(Ref,E(:,i));
    [s,k]=size(CrTbl);
    while(s>k)
        CrTbl=[CrTbl,zeros(s,1)];
        k=k+1;
    end
    while(s<k)
        CrTbl=[CrTbl;zeros(1,k)];
        s=s+1;
    end        
    InvCrTbl=repmat(max(max(CrTbl)),k,k)-CrTbl;
    [label, cost] = assignmentoptimal(InvCrTbl);
    for j=1:k
        idx=find(E(:,i)==label(j));
        E_relabel(idx,i)=j;
    end
end

end