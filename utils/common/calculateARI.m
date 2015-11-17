function ARIindex = calculateARI(cl1,cl2)
% Function calculates Adjusted Rand Index between partitions cl1 and cl2
% Input:
% cl1, cl2 - partitions in label format
%
% Output:
% ARIindex - value of ARI index

cl1 = cl1(:);
n = size(cl1, 1);

[n1, n2] = size(cl2);
if n2 == n
    cl2 = cl2';
    n2 = n1;
    n1 = n;
end

ARIindex = NaN(1, n2);

for icl = 1:n2
    
    ConTable=crosstab(cl1,cl2(:, icl)); % Contingency table
    na=sum(ConTable,2); % Summ over elements in rows in ContTable. Corresponds to first argument in Table
    nb=sum(ConTable,1); % Summ over elements in columns in ContTable. Corresponds to second argument in Table
    
    [numa, numb]=size(ConTable);
    n=length(cl1);
    
    Sa=0;
    for i=1:numa
        Sa=Sa+na(i)*(na(i)-1)/2;
    end
    
    Sb=0;
    for i=1:numb
        Sb=Sb+nb(i)*(nb(i)-1)/2;
    end
    
    Sab=0;
    for i=1:numa
        for j=1:numb
            Sab=Sab+ConTable(i,j)*(ConTable(i,j)-1)/2;
        end
    end
    
    ARIindex(icl)=(Sab-Sa*Sb/(n*(n-1)/2))/(0.5*(Sa+Sb)-Sa*Sb/(n*(n-1)/2));
end