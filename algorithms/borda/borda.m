function BordaConsensus=borda(E)

%% Borda Consensus
% Input: relabeled ensemble - E_relab(l x n) 
% Output: Bordra matrix B(n x kk)
% 0) do relabeling
% 1) in each partition for each object perform Rank:
% Rank ranges cluseters according to degree of similairty to object, that
% is - the most correspondent cluster r(1) is assigned with value kk, next
% one kk-1 and so on
% 1.2) For each cluster  B(r(t),j)=B(r(t),j)+kk-t+1, j=1..n
% 2) Normalizing matrix and setting cluster label for which B(:,j)


% Realization
% 0) relabeling Relabeling - Erel
Ref=E(:,1); % choosing refference partition
E=Relabeling(E,Ref);
% disp('Borda Consensus algorithm starts....');

[n,l]=size(E);

kk=max(max(E,[],1));

B=zeros(n,kk);

for i=1:l
    for j=1:n
        % 1) Start ERank
        e=E(j,:);
        r = ERank(e,kk);
        % end ERank        
        for t=1:kk
            % 1.2) assigning Ranks
            B(j,r(t))=B(j,r(t))+(kk-t+1);
        end               
    end
end


% 2)
B=B./norm(B',1);
[temp, BCtemp] = sort(B,2,'descend');

BordaConsensus=BCtemp(:,1);


end