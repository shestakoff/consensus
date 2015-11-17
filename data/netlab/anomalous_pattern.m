function [clus_list,cent]=ap(y,inde,least_square,least_moduli)
[R,C]=size(y);
if least_square==1
    tmp=y;
    z=sum(tmp.^2,2);
    h=find(z==max(z));
    [R_h,C_h]=size(h);
    if R_h>=2
        h=h(1);
    end
    cent=y(h,:);
    cent_new=0.1;
    while cent~=cent_new
        v=y-repmat(cent,R,1);
        u=sum(v.^2,2);
        clus_tmp=find(u<z);
        clus_list=inde(clus_tmp);
        n=length(clus_tmp);
        tmp1=y(clus_tmp',:);
        cent_new=sum(tmp1,1)/n;
        if cent~=cent_new
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
    z=sum(abs(tmp),2);
    h=find(z==max(z));
    [R_h,C_h]=size(h);
    if R_h>=2
        h=h(1);
    end
    cent=y(h,:);
    cent_new=0.1;
    while cent~=cent_new
        v=y-repmat(cent,R,1);
        u=sum(abs(v),2);
        clus_tmp=find(u<z);
        clus_list=inde(clus_tmp);
        n=length(clus_tmp);
        tmp1=y(clus_tmp',:);
        cent_new=median(tmp1,1);
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