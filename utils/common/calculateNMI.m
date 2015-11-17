function NMIindex = calculateNMI(cl1,cl2)
% Function calculates Adjusted Rand Index between partitions cl1 and cl2
% Input:
% cl1, cl2 - partitions in label format
%
% Output:
% NMIindex - value of ARI index

ConTable=crosstab(cl1,cl2); % Contingency table
na=sum(ConTable,2); % Summ over elements in rows in ContTable. Corresponds to first argument in Table
nb=sum(ConTable,1); % Summ over elements in columns in ContTable. Corresponds to second argument in Table

[numa, numb]=size(ConTable);
n=size(cl1,1);

Ha=0;
for i=1:numa
    if na(i)~=0
        Ha=Ha+na(i)*log2(na(i)/n);
    end
end

Hb=0;
for i=1:numb
    if nb(i)~=0
        Hb=Hb+nb(i)*log2(nb(i)/n);
    end
end
    
I=0;
for i=1:numa
    for j=1:numb
        if ConTable(i,j)~=0
            I=I+ConTable(i,j)*log2(n*ConTable(i,j)/(na(i)*nb(j)));
        end
    end
end

NMIindex=I/sqrt(Ha*Hb);
   
end