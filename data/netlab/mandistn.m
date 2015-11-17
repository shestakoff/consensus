function [dist_mat]=mandistn(y,syn,sk,cent)
[R_c,C_c]=size(cent);
[R,C]=size(y);
for i=1:R_c
    v=y-repmat(cent(i,:),R,1);
    dist_mat(i,:)=sum(syn.*abs(v),2)';
end