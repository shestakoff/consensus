function [sk,new_len_clus_list,real_cent]=anomalous_pattern_kmeansn(data,y,real,syn,least_square,least_moduli,re_threshold)
[R,C]=size(y);
tmp1=y;tp2=real;tp3=syn;
tmp2=zeros(R,1);
t=1;
st1=ones(R,1);
z=[1:R]';
%----------iterated anomalous pattern----------%
while z~=0
    [clus_list,cent]=anomalous_patternn(tmp1,tp2,tp3,z,least_square,least_moduli);
    len_clus_list(t)=length(clus_list);
    s(t,1:len_clus_list(t))=clus_list';
    tmp2(clus_list,1)=1;
    z=find(st1~=tmp2);
    tmp1=y(z,:);
    tp2=real(z,:);
    tp3=syn(z,:);
    t=t+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k=t-1;              %total clusters
j=1;
%-----take out the singleton cluster-----%
for i=1:k
    if len_clus_list(i)>re_threshold
        new_len_clus_list(j)=len_clus_list(i);
        tmp3(j,:)=s(i,:);
        j=j+1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k=j-1;                %remaining clusters
for i=1:k
    n=new_len_clus_list(i);
    if least_square==1
        cent_ksq(i,:)=sum(real(tmp3(i,1:n)',:),1)./sum(syn(tmp3(i,1:n)',:),1);   %the remaining centroids  least_square
        cent_kmo=0;
    end
    if least_moduli==1
        aa=0;bb=sort(syn(tmp3(i,1:n)',:));csum=sum(syn(tmp3(i,1:n)',:),1)/2;
        [rr,cc]=size(syn(tmp3(i,1:n)',:));
        for ii=1:cc
            for jj=1:rr
                aa=aa+bb(jj,ii);
                if aa>=csum(1,ii)
                    cent_kmo(i,ii)=y(jj,ii);break    %the remaining centroids   least_moduli
                end
            end
        end
        cent_ksq=0;
    end
end
[sk,real_cent]=straight_kmeansn(data,y,real,syn,tmp3,k,cent_ksq,cent_kmo);
[R_sk,C_sk]=size(sk);
for i=1:R_sk
    m=0;
    for j=1:C_sk
        if sk(i,j)>0
            m=m+1;
        end
    end
    new_len_clus_list(i)=m;
end
% %----------------ScaD and QScad table-------------%
% if least_square==1
%     %-----------------calculate Bkv----------------------%
%     for i=1:k
%         b(i,:)=((sum(y(sk(i,1:new_len_clus_list(i))',:),1)/new_len_clus_list(i)).^2)*new_len_clus_list(i);
%     end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     expl=sum(b,1);          %explain part
%     b_kplus=sum(b,2);       %B_1+,....,B_k+
%     t=sum(y.^2,1);          %T_v
%     unexpl=t-expl;          %unexplain part
%     bsc=sum(b_kplus);       %B(S,C)
%     wsc=sum(unexpl);        %W(S,C)
%     ty=sum(t);              %T(y)
%     b_kplus_tmp=[b_kplus;bsc;wsc;ty];
%     per=(b_kplus_tmp./ty)*100;
%     s=[b;expl;unexpl;t];
%     scad=[s,b_kplus_tmp,per];    %ScaD
%     rcnt=(b./repmat(t,k,1))*100;                        %B(k|v);Rcnt
%     dcnt=rcnt-(repmat(b_kplus./ty,1,C))*100;            %g(k|v);Dcnt
%     rci=(dcnt./((repmat(b_kplus./ty,1,C))*100))*100;    %q(k,v);RCI
%     rcnt_total=sum(rcnt,1);
%     dcnt_total=sum(dcnt,1);
%     rci_total=dcnt_total./(bsc/ty);
%     i=1;j=1;
%     while i<=5*k
%         qscad(i,:)=real_cent(j,:);
%         qscad(i+1,:)=stand_cent(j,:);
%         qscad(i+2,:)=rcnt(j,:);
%         qscad(i+3,:)=dcnt(j,:);
%         qscad(i+4,:)=rci(j,:);
%         i=i+5;j=j+1;
%     end
%     format bank
%     qscad=[qscad;rcnt_total;dcnt_total;rci_total];       %QScad
% end
% if least_moduli==1
%     %-----------------calculate Bkv----------------------%
%     for i=1:k
%         tmp4(i,:)=2*sum(abs(y(sk(i,1:new_len_clus_list(i)),:)));
%     end
%     ntv1=zeros(k,C);ntv2=zeros(k,C);ntv3=zeros(k,C);
%     for i=1:k
%         tmp5=y(sk(i,1:new_len_clus_list(i)),:);
%         for m=1:C
%             for n=1:new_len_clus_list(i)
%                 if tmp5(n,m)>stand_cent(i,m)
%                     ntv1(i,m)=ntv1(i,m)+1;
%                 elseif tmp5(n,m)==stand_cent(i,m)
%                     ntv2(i,m)=ntv2(i,m)+1;
%                 elseif tmp5(n,m)<stand_cent(i,m)
%                     ntv3(i,m)=ntv3(i,m)+1;
%                 end
%             end
%         end
%     end
%     for i=1:k
%         for j=1:C
%             if stand_cent(i,j)>0
%                 ntv(i,j)=ntv1(i,j)+ntv2(i,j)-ntv3(i,j);
%             elseif stand_cent(i,j)<0
%                 ntv(i,j)=ntv3(i,j)+ntv2(i,j)-ntv1(i,j);
%             end
%         end
%     end
%     b=tmp4+ntv.*abs(stand_cent);
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     expl=sum(b,1);          %explain part
%     b_kplus=sum(b,2);       %B_1+,....,B_k+
%     t=sum(abs(y),1);        %T_v
%     unexpl=t-expl;          %unexplain part
%     bsc=sum(b_kplus);       %B(S,C)
%     wsc=sum(unexpl);        %W(S,C)
%     ty=sum(t);              %T(y)
%     b_kplus_tmp=[b_kplus;bsc;wsc;ty];
%     per=(b_kplus_tmp./ty)*100;
%     s=[b;expl;unexpl;t];
%     scad=[s,b_kplus_tmp,per];    %ScaD
%     rcnt=(b./repmat(t,k,1))*100;                        %B(k|v);Rcnt
%     dcnt=rcnt-(repmat(b_kplus./ty,1,C))*100;            %g(k|v);Dcnt
%     rci=(dcnt./((repmat(b_kplus./ty,1,C))*100))*100;    %q(k,v);RCI
%     rcnt_total=sum(rcnt,1);
%     dcnt_total=sum(dcnt,1);
%     rci_total=dcnt_total./(bsc/ty);
%     i=1;j=1;
%     while i<=5*k
%         qscad(i,:)=real_cent(j,:);
%         qscad(i+1,:)=stand_cent(j,:);
%         qscad(i+2,:)=rcnt(j,:);
%         qscad(i+3,:)=dcnt(j,:);
%         qscad(i+4,:)=rci(j,:);
%         i=i+5;j=j+1;
%     end
%     format bank
%     qscad=[qscad;rcnt_total;dcnt_total;rci_total];       %QScad
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%