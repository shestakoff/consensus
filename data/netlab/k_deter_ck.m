function [sk_ck,sk_len_ck,stand_ck,real_ck]=k_deter_ck(data,y,k_start,k_end,rows,v,times_app,cent_i,knum,wkf,len_clus,kl,stand_c,real_c)
[R,C]=size(y);
t=sum(sum(y.^2));
[R_wk,C_wk]=size(wkf);     
for i=1:C_wk
    ck1(i)=((t-wkf(i))/(knum(i)-1))/(wkf(i)/(rows-knum(i)));
end

indx=find(ck1==max(ck1));
[R_ind,C_ind]=size(indx);
if C_ind>=2
    inx=indx(1);
else
    inx=indx;
end
sk_ck=kl{inx};
sk_len_ck=len_clus{inx};
stand_ck=stand_c{inx};
real_ck=real_c{inx}; 