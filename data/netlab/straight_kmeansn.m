function [clus_list,real_cent]=straight_kmeansn(data,y,real,syn,sk,k,cent_sq,cent_mo)
[R,C]=size(data);
if cent_mo==0
    [R_k,C_k]=size(sk);
    clus_list=sk;
    clus_list_new=0.1;
    [R_csq,C_csq]=size(cent_sq);
    while clus_list~=clus_list_new
        dist_mat=distn(y,syn,sk,cent_sq);
        [R_dis,C_dis]=size(dist_mat);
        if R_dis>=2
            for j=1:R
                if dist_mat(1,j)==dist_mat(2,j)
                    dist_mat(1,j)=dist_mat(1,j)-0.1;
                end
            end
        end
        [clus_x, clus_y]=find(dist_mat==repmat(min(dist_mat),R_csq,1));   %find clusters with min distance rule
        clus_z=[clus_x clus_y];
        %----------find new cluster list-----------%
        j=1;
        for i=1:k
            clus_a=find(clus_x==i);
            if length(clus_a)~=0
                len_clus_list(j)=length(clus_a);
                clus_list_new(j,1:len_clus_list(j))=clus_y(clus_a);
                j=j+1;
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %----------calculate new centroids-----------%
        for i=1:j-1
            n=len_clus_list(i);
            cent_sq(i,:)=sum(real(clus_list_new(i,1:n)',:),1)./sum(syn(clus_list_new(i,1:n)',:),1);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %----check if new cluster list is equal to the old list----%
        [R_clus,C_clus]=size(clus_list);
        [R_clus_new,C_clus_new]=size(clus_list_new);
        if C_clus_new>C_clus
            clus_list=[clus_list zeros(R_clus,C_clus_new-C_clus)];
        elseif C_clus>C_clus_new
            clus_list;
            clus_list_new;
            clus_list_new=[clus_list_new zeros(R_clus,C_clus-C_clus_new)]
        end
        if R_clus_new>R_clus
            clus_list=[clus_list;zeros(R_clus_new-R_clus,C_clus)];
        elseif R_clus>R_clus_new
            clus_list_new=[clus_list_new;zeros(R_clus-R_clus_new, C_clus_new)];
        end       
        if clus_list~=clus_list_new
            clus_list=clus_list_new;
            [temp,Cc]=size(clus_list);
            clus_list_new=zeros(k,Cc);
        else
            clus_list=clus_list_new;
            clus_list_new=clus_list;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    for i=1:j-1
        n=len_clus_list(i);
        real_cent(i,:)=sum(real(clus_list(i,1:n)',:),1)./sum(syn(clus_list(i,1:n)',:),1);
    end
%     for i=1:j-1
%         n=len_clus_list(i);
%         cent(i,:)=sum(real(clus_list(i,1:n)',:),1)./sum(syn(clus_list(i,1:n)',:),1);
%     end
elseif cent_sq==0
    [R_k,C_k]=size(sk);
    clus_list=sk;
    clus_list_new=0.1;
    [R_cmo,C_cmo]=size(cent_mo);
    while clus_list~=clus_list_new
        dist_matn=mandistn(y,syn,sk,cent_mo);
        [R_dis,C_dis]=size(dist_matn);
        if R_dis>=2
            for j=1:R
                if dist_matn(1,j)==dist_matn(2,j)
                    dist_matn(1,j)=dist_matn(1,j)-0.1;
                end
            end
        end
        [clus_xn, clus_yn]=find(dist_matn==repmat(min(dist_matn),R_cmo,1));   %find clusters with min distance rule
        clus_z=[clus_xn clus_yn]
        %----------find new cluster list-----------%
        j=1;
        for i=1:k
            clus_a=find(clus_xn==i);
            if length(clus_a)~=0
                len_clus_list(j)=length(clus_a);
                clus_list_new(j,1:len_clus_list(j))=clus_yn(clus_a);
                j=j+1;
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %----------calculate new centroids-----------%
        for i=1:j-1
            n=len_clus_list(i);
            aa=0;bb=sort(syn(clus_list_new(i,1:n)',:));csum=sum(syn(clus_list_new(i,1:n)',:),1)/2;
            [rr,cc]=size(syn(clus_list_new(i,1:n)',:));
            for ii=1:cc
                for jj=1:rr
                    aa=aa+bb(jj,ii);
                    if aa>=csum(1,ii)
                        cent_mo(i,ii)=y(jj,ii);break
                    end
                end
            end        
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %----check if new cluster list is equal to the old list----%
        [R_clus,C_clus]=size(clus_list);
        [R_clus_new,C_clus_new]=size(clus_list_new);
        if C_clus_new>C_clus
            clus_list=[clus_list zeros(R_clus,C_clus_new-C_clus)];
        elseif C_clus>C_clus_new
            clus_list_new=[clus_list_new zeros(R_clus,C_clus-C_clus_new)];
        end
        if R_clus_new>R_clus
            clus_list=[clus_list;zeros(R_clus_new-R_clus,C_clus)];
        elseif R_clus>R_clus_new
            clus_list_new=[clus_list_new;zeros(R_clus-R_clus_new, C_clus_new)];
        end 
        if clus_list~=clus_list_new
            clus_list=clus_list_new;
            [temp,Cc]=size(clus_list);
            clus_list_new=zeros(k,Cc);
        else
            clus_list=clus_list_new;
            clus_list_new=clus_list;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    for i=1:j-1
        n=len_clus_list(i);
        aa=0;bb=sort(syn(clus_list(i,1:n)',:));csum=sum(syn(clus_list(i,1:n)',:),1)/2;
        [rr,cc]=size(syn(clus_list(i,1:n)',:));
        for ii=1:cc
            for jj=1:rr
                aa=aa+bb(jj,ii);
                if aa>=csum(1,ii)
                    real_cent(i,ii)=data(jj,ii);break
                end
            end
        end
    end
%     for i=1:k
%         aa=0;bb=sort(syn(clus_list(i,1:n)',:));csum=sum(syn(clus_list(i,1:n)',:),1)/2;
%         [rr,cc]=size(syn(clus_list(i,1:n)',:));
%         for ii=1:cc
%             for jj=1:rr
%                 aa=aa+bb(jj,ii);
%                 if aa>=csum(1,ii)
%                     cent(i,ii)=y(jj,ii);break
%                 end
%             end
%         end
%     end
end