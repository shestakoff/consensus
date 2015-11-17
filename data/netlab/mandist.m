function [dist_mat]=mandist(y,cent)
[R_c,C_c]=size(cent);
[R,C]=size(y);
for i=1:R_c
    v=y-repmat(cent(i,:),R,1);
    dist_mat(i,:)=sum(abs(v),2)';
end