function [dist_mat]=dist(y,cent)
[R_c,C_c]=size(cent);
[R,C]=size(y);
for i=1:R
    v=repmat(y(i,:),R_c,1)-cent;
    dist_mat(:,i)=sum(v.^2,2);
end