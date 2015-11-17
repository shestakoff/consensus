function [A,P]=BuildConsensusMatrices(E)
% Матрица A, где a(i,j)- (доля) разбиений, в котором x(i) и x(j) в
% одном классе
% Матрица P, где p(i,j) - сумма обратных численностям одинаковых
% классов


% А
disp('Building Consensus and Projection matrices....');

[n,l]=size(E);
X=[];
P=zeros(n,n);
for i=1:l
    curpart=E(:,i);
    labels=unique(curpart(~isnan(curpart)));
    x=[];
    for j=1:n
        x=[x;(labels==curpart(j))'];
    end
    X=[X,x];
    p=x'*x;
    p=p.^(-1).*(p>0);
    p(isnan(p))=0;
    
    P=P+x*p*x';
end

A=X*X';


% A=zeros(n,n);
% 
% 
% for i=1:n
%     for j=1:i
%         A(i,j)=length(find(E(i,:)==E(j,:)));
%     end
% end
% A=A+A'-diag(diag(A));
% 
% % Р
% 
% P=zeros(n,n);
% 
%  for i=1:n
%      for j=1:i
%          idx=find(E(i,:)==E(j,:));
%          if(~isempty(idx))
%              for t=1:length(idx)
%                  P(i,j)=P(i,j)+1/length(find(E(:,idx(t))==E(i,idx(t))));
%              end
%          end
%      end
%  end
% P=P+P'-diag(diag(P));
% 
end