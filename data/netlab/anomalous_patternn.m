function [clus_list,cent]=apn(y,real,syn,inde,least_square,least_moduli)
[R,C]=size(y);
if least_square==1
    tmp=y;
    gm=(sum(real)/R)./(sum(syn)/R);
    tp1=y-repmat(gm,R,1);
    z=sum(tp1.^2,2);
    h=find(z==max(z));
    [R_h,C_h]=size(h);
    if R_h>=2
        h=h(1);
    end
    cent=y(h,:);
    cent_new=0.1;
    while cent~=cent_new
        v=y-repmat(cent,R,1);
        u=sum(syn.*(v.^2),2);
        clus_tmp=find(u<z);
        clus_list=inde(clus_tmp);
        n=length(clus_tmp);
        tmp1=real(clus_tmp',:);
        tmp2=syn(clus_tmp',:);
        cent_new=sum(tmp1,1)./sum(tmp2,1);
        if round(cent)~=round(cent_new)
            cent=cent_new;
            [temp,Cc]=size(cent);
            cent_new=zeros(1,Cc);
        else
            cent=cent_new;
            cent_new=cent;
        end
    end
elseif least_moduli==1
    tmp=y;
    gm=(sum(real)/R)./(sum(syn)/R);
    tp1=y-repmat(gm,R,1);
    z=sum(abs(tp1),2);
    h=find(z==max(z));
    [R_h,C_h]=size(h);
    if R_h>=2
        h=h(1);
    end
    cent=y(h,:);
    cent_new=0.1;
    while cent~=cent_new
        v=y-repmat(cent,R,1);
        u=sum(syn.*abs(v),2);
        clus_tmp=find(u<z);
        clus_list=inde(clus_tmp);
        n=length(clus_tmp);
        aa=0;bb=sort(syn(clus_tmp',:));csum=sum(syn(clus_tmp',:),1)/2;
        [rr,cc]=size(syn(clus_tmp',:));
        for ii=1:cc
            for jj=1:rr
                aa=aa+bb(jj,ii);
                if aa>=csum(1,ii)
                    cent_new(ii)=y(jj,ii);break
                end
            end
        end        
        if cent~=cent_new
            cent=cent_new;
            [temp,Cc]=size(cent);
            cent_new=zeros(1,Cc);
        else
            cent=cent_new;
            cent_new=cent;
        end
    end
end