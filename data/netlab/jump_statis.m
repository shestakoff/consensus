function [sk,sk_len,stand,real]=jump_statis(data,y,k_start,k_end,rows,v,times_app,cent_i,knum,wkf,len_clus,kl,stand_c,real_c)
[R,C]=size(y);
ga=inv(cov(y));
[R_k,C_k]=size(knum);
z=1;
for iter=1:C_k
    for is=1:knum(iter)
        for js=1:len_clus{iter}(is)
            tmp=y(kl{iter}(is,js),:)-stand_c{iter}(is,:);
            dist_mat{iter}(z)=tmp*ga*tmp';
            z=z+1;
        end
    end
end
for iter=1:C_k
    diste(iter)=sum(dist_mat{iter})/(v*rows);
end
tran_power=v/2;     %transformation power
dis_po=1./(diste.^tran_power);     %dk with transformation power
for i=2:C_k
    jump(i)=dis_po(i)-dis_po(i-1);      %jump
end
jump(1)=dis_po(1);

ind=find(jump==max(jump));
[R_ind,C_ind]=size(ind);
if C_ind>=2
    inde=ind(1);
else
    inde=ind;
end
sk=kl{inde};
sk_len=len_clus{inde};
stand=stand_c{inde};
real=real_c{inde};