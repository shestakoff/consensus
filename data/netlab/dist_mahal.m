function [dist_mat]=dist_mahal(y,cent)
[R_c,C_c]=size(cent);
[R,C]=size(y);
cv=inv(cov(y));
for i=1:R
    v=repmat(y(i,:),R_c,1)-cent;
    for j=1:R_c
        dist_mat(j,i)=v(j,:)*cv*v(j,:)';
    end
end