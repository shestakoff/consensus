function [clus_list,cent,real_cent]=straight_kmeans_mahal(data,y,sk,k,cent_sq,cent_mo)
[R,C]=size(data);
if cent_mo==0
    [R_k,C_k]=size(sk);
    clus_list=sk;
    clus_list_new=0.1;
    [R_csq,C_csq]=size(cent_sq);
    while clus_list~=clus_list_new
        dist_mat=dist_mahal(y,cent_sq);
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
            cent_sq(i,:)=sum(y(clus_list_new(i,1:n)',:),1)/n;
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
        real_cent(i,:)=sum(data(clus_list(i,1:n)',:),1)/n;
    end
    cent=cent_sq;
elseif cent_sq==0
    [R_k,C_k]=size(sk);
    clus_list=sk;
    clus_list_new=1e-100;
    [R_cmo,C_cmo]=size(cent_mo);
    while clus_list~=clus_list_new
        dist_mat=mandist(y,cent_mo);
        [R_dis,C_dis]=size(dist_mat);
        if R_dis>=2
            for j=1:R
                if dist_mat(1,j)==dist_mat(2,j)
                    dist_mat(1,j)=dist_mat(1,j)-0.1;
                end
            end
        end
        [clus_x, clus_y]=find(dist_mat==repmat(min(dist_mat),R_cmo,1));   %find clusters with min distance rule
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
        for i=1:k
            n=len_clus_list(i);
            cent_mo(i,:)=median(y(clus_list_new(i,1:n)',:),1);
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
            clus_list_new=1e-100;
        else
            clus_list=clus_list_new;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    for i=1:k
        n=len_clus_list(i);
        real_cent(i,:)=median(data(clus_list(i,1:n)',:),1);
    end
    cent=cent_mo;
end