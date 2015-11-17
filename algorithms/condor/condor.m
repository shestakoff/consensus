function CondorsetConsensus=condor(E)
%% Condarset Consensus
% Input: relabeled ensemble - E_relab(l x n) 
% Output: Condorset matrix C(n x kk)
% 0) do relabeling
% 1) in each partition for each object perform Rank:
% Rank ranges cluseters according to degree of similairty to object, that
% is - the most correspondent cluster r(1) is assigned with value kk, next
% one kk-1 and so on
% 1.2) calculate matrix M(kxk) -% Condorset sum matrix where element (i,j) %
% shows how many times ith cluster was more pereferable than jth
% 2) Calculate matrix Ñ, element (i,j) corresponds to number of cases
% when jth cluster was chomen over ith in more than l/2 times

[n,l]=size(E);
kk=max(max(E,[],1));

C=zeros(n,kk);

for j=1:n
    M=zeros(kk,kk);
    for i=1:l
        e=E(j,:);
        r = ERank(e,kk);
        for t=1:kk
            M(r(t),r((t+1):kk))=M(r(t),r((t+1):kk))+1;
        end
    end
    for t=1:kk
        % Start count
        C(j,t)=Count(M(t,:),l/2);
    end
end

C=C./norm(C',1);
[temp, CCtemp] = sort(C,2,'descend');

CondorsetConsensus=CCtemp(:,1);
end