function [sk_hk,sk_len_hk,real_hk]=k_deter_hkn(data,y,real,syn,k_start,k_end,rows,v,times_app)
[R,C]=size(y);
ks=k_end-k_start+1;
times=1;
for i=k_start:k_end
    for dif_init=1:times_app
        rp=randperm(R);
        cent_i=y(rp(1:i),:);
        cent_init{i,dif_init}=cent_i;
        cent_mo=0;sk=zeros(i,i);
        [clus_liste,re_cent]=straight_kmeansn(data,y,real,syn,sk,i,cent_i,cent_mo);
        [R_kt,C_k]=size(clus_liste);
        R_k=0;
        for s=1:R_kt
            if clus_liste(s,1)>0
                R_k=R_k+1;
            end
        end
        len=zeros(1,R_k);
        for k=1:R_k
            m=0;
            for l=1:C_k
                if clus_liste(k,l)>0
                    m=m+1;
                end
            end
            len(k)=m;
        end
        clus_list=clus_liste(1:R_k,:);
        len_clus_liste{dif_init}=len;
        kliste{dif_init}=clus_list;
        k_nume(dif_init)=R_k;
        real_cente{dif_init}=re_cent;
%         %------------------consensus matrix---------------------%
%         M{dif_init}=zeros(R,R);
%         for ia=1:R_k
%             for ja=1:len(ia)
%                 for ka=1:R_k
%                     for la=1:len(ka)
%                         if ia==ka
%                             if ja==la
%                                 M{dif_init}(clus_list(ia,ja),clus_list(ka,la))=0;
%                             end
%                             M{dif_init}(clus_list(ia,ja),clus_list(ka,la))=1;
%                         else
%                             M{dif_init}(clus_list(ia,ja),clus_list(ka,la))=0;
%                         end
%                     end
%                 end
%             end
%         end
    end
%     Mtemp{times}=zeros(R,R);
%     for iter=1:times_app
%         Mtemp{times}=Mtemp{times}+M{iter};
%     end
%     lmtemp=Mtemp{times}./times_app;
%     lm{times}=lmtemp;
%     [lmi,lmj]=size(lmtemp);
%     lc=reshape(lmtemp,[lmi*lmj 1]);
%     sigma=var(lc);mea=mean(lc);
%     avdis(times)=mea*(1-mea)-sigma;
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for iter=1:times_app
        for ii=1:k_nume(iter)
            wsc{iter}(ii,:)=sum(sum((y(kliste{iter}(ii,1:len_clus_liste{iter}(ii))',:)-repmat(real_cente{iter}(ii,:),len_clus_liste{iter}(ii),1)).^2,2),1);
        end
    end
    for iter=1:times_app
        wk(iter)=sum(wsc{iter},1);
    end
    [R_wk,C_wk]=size(wk);
    indx=find(wk==min(wk));
    [R_ind,C_ind]=size(indx);
    if C_ind>=2
        inx=indx(1);
    else
        inx=indx;
    end
    len_clus_list{times}=len_clus_liste{inx};
    klist{times}=kliste{inx};
    k_num(times)=k_nume(inx);
    real_cent{times}=real_cente{inx};
    times=times+1;
end
for ia=1:ks-1
    contable{ia}=zeros(k_num(ia),k_num(ia+1));
    for i=1:k_num(ia)
        for j=1:len_clus_list{ia}(i)
            for k=1:k_num(ia+1)
                for l=1:len_clus_list{ia+1}(k)
                    if klist{ia}(i,j)==klist{ia+1}(k,l)
                        contable{ia}(i,k)=contable{ia}(i,k)+1;
                    end
                end
            end
        end
    end
end
% for i=1:ks-1
%    contable{i}
% end
for i=1:ks-1
    cloy(i)=sum(sum(contable{i})-max(contable{i}));
end

for iter=1:ks
    for i=1:k_num(iter)
        wsc1{iter}(i,:)=sum(sum((y(klist{iter}(i,1:len_clus_list{iter}(i))',:)-repmat(real_cent{iter}(i,:),len_clus_list{iter}(i),1)).^2,2),1);
    end
end
for iter=1:ks
    wk1(iter)=sum(wsc1{iter},1);
end
knum=k_num;wkf=wk1;
% for i=1:C_wk
%     kl{i},
%     for j=1:knum(i)
%         stand_c{i}(j,:)
%         y(kl{i}(j,1:len_clus{i}(j)),:)
%     end
% end
for i=1:ks-1
    hk1(i)=((wkf(i)/wkf(i+1))-1)*(rows-knum(i)-1);
end
wkf
indx=find(hk1<=10);
[R_ind,C_ind]=size(indx);
if C_ind>=2
    index=indx(1);
elseif C_ind==1
    index=indx;
elseif C_ind==0
    index=find(hk1==min(hk1));
end

sk_hk=klist{index};
sk_len_hk=len_clus_list{index};
real_hk=real_cent{index};

% %--------find the sorted set of entities in consensus matrix------%
% for i=1:ks
%     x{i}=-1;
%     t=1;len_x(i)=0;
%     for j=1:R
%         for k=1:R
%             inx=find(x{i}==lm{i}(j,k));
%             [R_inx,C_inx]=size(inx);
%             if C_inx==0
%                 x{i}(t)=lm{i}(j,k);
%                 t=t+1;
%                 len_x(i)=len_x(i)+1;
%             end
%         end
%     end
% end
% for i=1:ks
%     x{i}=sort(x{i});
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %-----calculate the cumulative distribution function-----%  
% m=R*(R-1)/2;
% for i=1:ks
%     for ia=1:len_x(i)
%         f(i,ia)=0;
%         for j=1:R
%             for k=1:R
%                 if j<k
%                     if lm{i}(j,k)<=x{i}(ia)
%                         f(i,ia)=f(i,ia)+1;
%                     end
%                 end
%             end
%         end
%     end
% end
% f=f/m;
% % for i=1:ks
% %     hold on
% %     plot(x{i},f(i,1:len_x(i)))
% % end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% for i=1:ks
%     a(i)=0;
%     for j=2:len_x(i)
%         a(i)=a(i)+(x{i}(j)-x{i}(j-1))*f(i,j);
%     end
% end
% 
% for i=1:ks-1
%     davdis(i)=(avdis(i)-avdis(i+1))/avdis(i+1);
% end
% 
% indx=find(davdis==max(davdis));
% [R_ind,C_ind]=size(indx);
% if C_ind>=2
%     index=indx(1);
% elseif C_ind==1
%     index=indx;
% end
% sk_da=klist{index};
% sk_len_da=len_clus_list{index};
% stand_da=stand_cent{index};
% real_da=real_cent{index};
% 
% for i=1:ks-1
%     deltak(i+1)=(a(i+1)-a(i))/a(i);
% end
% 
% indx=find(deltak==max(deltak));
% [R_ind,C_ind]=size(indx);
% if C_ind>=2
%     index=indx(1);
% elseif C_ind==1
%     index=indx;
% end
% sk_cd=klist{index};
% sk_len_cd=len_clus_list{index};
% stand_cd=stand_cent{index};
% real_cd=real_cent{index};