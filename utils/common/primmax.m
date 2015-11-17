function B=primmax(A,N,param)
%Prims Algorithm maximum spanning tree
%coded by Vikramaditya V. Kundur


A=A-diag(diag(A));
mi=min(min(A(A>0)));
ma=max(max(A(A>0)));
n=size(A,1);

B=zeros(n,n);
A1=A;
iter=1;
fprintf('Spanning Tree Iteration ')

while(any(A(:)~=0) && iter<N)

  fprintf('%d ' ,iter)
% fprintf('\n\n********* Iteration %d ***********\n\n',iter);
% fclose(fid);
% fid = fopen('Result.txt','wt');     % Output file
% fprintf(fid,'Original matrix\n\n'); % Printing the original matrix in the output file
% for i=1:n
%     for k=1:n
%         fprintf(fid,'%6d',A(i,k));  
%     end
%     fprintf(fid,' \n');
% end

%%% Если минимум спаннинг трии то
% for i=1:n
%     for j=1:n
%          if A(i,j)==0
%                A(i,j)=inf;
%          end
%     end
% end

% fprintf('\nMatrix A\n');
% for i=1:n
%     for k=1:n
%         if i==k
%             fprintf('%6d',0);
%         else
%             fprintf('%6d',A(i,k));
%         end        
%     end
%             fprintf(' \n');
% end
b=zeros(n,n);
listV=zeros(1,n);
[row,col] = find((A>0 & ~isinf(A)),1,'first');
listV(col)=1;
e=1;
while (e<n)
    maximum=0;
     for i=1:n
        if listV(i)==1
            for j=1:n
                if listV(j)==0
                   if maximum<A(i,j)
                        maximum=A(i,j);
                        val=A(i,j);
                        start=i;
                        distan=j;
                    end
                end
            end
        end
    end
    listV(distan)=1;
    b(min([start,distan]),max([start,distan]))=val;
    e=e+1;
end

% fprintf('\nMatrix B\n');
% for i=1:n
%     for k=1:n
%         if i==k
%             fprintf('%6d',0);
%         else
%             fprintf('%6d',b(i,k));
%         end        
%     end
%             fprintf(' \n');
% end

b=b+b';
B=B+b;
A=A-b;
% A1=A1-b./(ma-iter);
iter=iter+1;
end
B=B;
fprintf('\n')
end


