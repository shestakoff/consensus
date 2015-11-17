function cVoteConsensus=cvote(E)

%% Ayad cVote
% Calculate entropy for each partition and sort by its descending order
% Refference partition Eo - first partition E1
% Staring from second partition i=2:l:
% % Calc W(i)=inv(E(i)'E(i))*E(i)'*Eo - coefs that minimize square of
% errors
 % % V(i)= E(i)*W(i)
% % Eo=((i-1)/i)*Eo+(1/i)*(V(i))
% Output: Eo

[n,l]=size(E);

entr=partition_entropy(E);

[~,order] = sort(entr,'descend');

E_ord=E(:,order);
u=unique(E_ord(:,1));
Eo=zeros(n,length(u));
for j=1:length(u)
    idx=find(E_ord(:,1)==u(j));
    Eo(idx,j)=1; %  Eo
end

for i=2:l
   u=unique(E_ord(:,i));
   Ei=zeros(n,length(u));
    for j=1:length(u)
        idx=find(E_ord(:,i)==u(j));
        Ei(idx,j)=1; %  E(i)
    end 
    W=inv(Ei'*Ei)*Ei'*Eo;
    V=Ei*W;
    Eo=((i-1)/i)*Eo+(1/i)*V;
    clear Ei W V u
end

[temp, cVtemp] = sort(Eo,2,'descend');

cVoteConsensus=cVtemp(:,1);

