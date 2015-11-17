function VotingConsensus=vote(E)

%% Voting Scheme
%  аждое разбиение представл€ютс€ в виде булевской матрицы U(i) размерности nxk,
% кажда€ строка которой содержит только одну единицу в соотвествующем
% классу столбце. 
% Input: Mатрицы U
% Output: VotingConsensus(n x kk)
% 1) P(1)=U(1); Per(1)=id
% 2) Ќачина€ со второго разбиени€ необходимо найти такую перестановку,
% котора€ максимизирует специальный критерий
% 3) –езультирующее согласованное разбиение получаетс€ в результате
% последнего шага

[n,l]=size(E);
kk=max(max(E,[],1));

VotingConsensus=zeros(n,kk);
P_prev=zeros(n,kk);
for t=1:kk
    idx=find(E(:,1)==t);
    P_prev(idx,t)=1; % наше –(1)
end


for m=2:l
    U_cur=zeros(n,kk);
    for t=1:kk
        idx=find(E(:,m)==t);
        U_cur(idx,t)=1; % наше U(m)
    end
    CrTbl=P_prev'*U_cur;
    InvCrTbl=repmat(max(max(CrTbl)),kk,kk)-CrTbl;
    [label, cost] = assignmentoptimal(InvCrTbl);
    P_prev=(m-1)*P_prev/m+U_cur(:,label');
end
[temp, VCtemp] = sort(P_prev,2,'descend');

VotingConsensus=VCtemp(:,1);

end
