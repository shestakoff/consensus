clear all
gen=input('Do you want to generate data? Yes(Y):generate data; No(N) Y/N : ','s');
if gen=='Y' | gen=='y'
    k=input('How many clusters do you want for data generation? ');
    dim=input('How many rows do you want for data generation? ');
    v=input('How many features do you want for data generation? ');
    type=input('What model of data generation do you want to use (1)spherical (2)PPCA (3)Boris?');
    if type==2
        disp('PPCA Data generation.....')
        hid_dim=input('How many hidden dimensions do you want for data generation? ');
        sigma_square=input('How many sigma square do you want? ');
        discen=input('How many distance between cluster centers? ');
        choice=input('What kind of ellipsoid size (1)k (2)k.^2 (3)2 (4)1 ?');
    elseif type==1
        disp('Spherical Data generation.....')
        discen=input('How many distance between cluster centers? ');
        choice=input('What kind of ellipsoid size (1)k (2)k.^2 (3)2 (4)1 ?');
    elseif type==3
        disp('Boris Option.......')
        discen=input('How many distance between cluster centers? ');
    end
else
    data=load('dc_c1.dat');
    data1=load('mu_c1.dat');
%     real=load('test_gg.dat');syn=load('test_ff.dat');data=real./syn;
    [dim v]=size(data);
    [dim1 v1]=size(data1);
end
times=input('How many simulations do you want? ');

for times_count=1:times
    con_table_mo=0;con_table_sq=0;
    if gen=='Y' | gen=='y'
        if type==2
            mix=gmm(v,k,'ppca',hid_dim,dim,sigma_square,discen);
            centres=mix.centres;priors=mix.priors;
            [data,label]=gmmsamp(mix,dim,choice);
            del(times_count)=1-sum(mix.priors.^2);
            fprintf(fid60,'%f\n',del(times_count));
            if choice==2
                save('data3.dat','data','-ASCII')
            elseif choice==4
                save('data4.dat','data','-ASCII')
            end
        elseif type==1
            mix=gmm(v,k,'spherical',1,dim,1,discen);
            centres=mix.centres;priors=mix.priors;
            [data,label]=gmmsamp(mix,dim,choice);
            del(times_count)=1-sum(mix.priors.^2);
            fprintf(fid60,'%f\n',del(times_count));
            save('data2.dat','data','-ASCII')
        elseif type==3
            [data,label,priors,centres]=gareth_randn(v,k,dim,discen);
            del(times_count)=1-sum(priors.^2);
            save('data1.dat','data','-ASCII')
        end
    else
        data=load('dc_c1.dat');
    end
    [R,C]=size(data);
    num_cate=0;wh_col=0;

    y=standard(data,num_cate,wh_col,1,0);
    
    k_deter_start=2;
    k_deter_end=20;
    times_app=10;

    [sk_h,sk_len_h,stand_cent_h,real_cent_h]=k_deter_hk(data,y,k_deter_start,k_deter_end,dim,v,times_app);
    [R_h,C_h]=size(sk_h);
    clus_h(times_count)=R_h;
    
    removal_threshold_sq=1;
    [sk_sq,sk_len_sq,stand_cent_sq,real_cent_sq]=anomalous_pattern_kmeans(data,y,1,0,removal_threshold_sq);
    [R_sq,C_sq]=size(sk_sq);
    
    removal_threshold_mo=1;
    ym=standard(data,num_cate,wh_col,0,1);
    [sk_mo,sk_len_mo,stand_cent_mo,real_cent_mo]=anomalous_pattern_kmeans(data,ym,0,1,removal_threshold_mo);
    [R_mo,C_mo]=size(sk_mo);
    
    removal_threshold_sq=1;
    [sk_sq_r,sk_len_sq_r,stand_cent_sq_r,real_cent_sq_r]=anomalous_pattern_kmeans(data,y,1,0,removal_threshold_sq);
    [R_sq_r,C_sq_r]=size(sk_sq_r);
    while R_sq_r>=R_h*1.15
        removal_threshold_sq=removal_threshold_sq+1;
        [sk_sq_r,sk_len_sq_r,stand_cent_sq_r,real_cent_sq_r]=anomalous_pattern_kmeans(data,y,1,0,removal_threshold_sq);
        [R_sq_r,C_sq_r]=size(sk_sq_r);
    end
    remove_thres_sq(times_count)=removal_threshold_sq;
    clus_sq_r(times_count)=R_sq_r;

    %     for i=1:R_sq
    %         stand_cent_sq(i,:)
    %         y(sk_sq(i,1:sk_len_sq(i))',:)
    %     end

    removal_threshold_mo=1;
    ym=standard(data,num_cate,wh_col,0,1);
    [sk_mo_r,sk_len_mo_r,stand_cent_mo_r,real_cent_mo_r]=anomalous_pattern_kmeans(data,ym,0,1,removal_threshold_mo);
    [R_mo_r,C_mo_r]=size(sk_mo_r);
    while R_mo_r>=R_h*1.15
        removal_threshold_mo=removal_threshold_mo+1;
        [sk_mo_r,sk_len_mo_r,stand_cent_mo_r,real_cent_mo_r]=anomalous_pattern_kmeans(data,ym,0,1,removal_threshold_mo);
        [R_mo_r,C_mo_r]=size(sk_mo_r);
    end
    remove_thres_mo(times_count)=removal_threshold_mo;
    clus_mo_r(times_count)=R_mo_r;
    
    
    %     for i=1:R_mo
    %         stand_cent_mo(i,:)
    %         y(sk_mo(i,1:sk_len_mo(i))',:)
    %     end   
    

    sk_len_sq,sk_len_mo
    sk_len_sq_r,sk_len_mo_r
    removal_threshold_sq,removal_threshold_mo
    sk_len_h
    real_cent_sq,real_cent_mo,real_cent_sq_r,real_cent_mo_r,real_cent_h
end

for times_count=1:times
    con_table_mo=0;con_table_sq=0;
    if gen=='Y' | gen=='y'
        if type==2
            mix=gmm(v,k,'ppca',hid_dim,dim,sigma_square,discen);
            centres=mix.centres;priors=mix.priors;
            [data,label]=gmmsamp(mix,dim,choice);
            del(times_count)=1-sum(mix.priors.^2);
            fprintf(fid60,'%f\n',del(times_count));
            if choice==2
                save('data3.dat','data','-ASCII')
            elseif choice==4
                save('data4.dat','data','-ASCII')
            end
        elseif type==1
            mix=gmm(v,k,'spherical',1,dim,1,discen);
            centres=mix.centres;priors=mix.priors;
            [data,label]=gmmsamp(mix,dim,choice);
            del(times_count)=1-sum(mix.priors.^2);
            fprintf(fid60,'%f\n',del(times_count));
            save('data2.dat','data','-ASCII')
        elseif type==3
            [data,label,priors,centres]=gareth_randn(v,k,dim,discen);
            del(times_count)=1-sum(priors.^2);
            save('data1.dat','data','-ASCII')
        end
    else
        data1=load('mu_c1.dat');
    end
    [R1,C1]=size(data1);
    num_cate=0;wh_col=0;

    y1=standard(data1,num_cate,wh_col,1,0);
    
    k_deter_start=2;
    k_deter_end=20;
    times_app=10;

    [sk_hm,sk_len_hm,stand_cent_hm,real_cent_hm]=k_deter_hk(data1,y1,k_deter_start,k_deter_end,dim1,v1,times_app);
    [R_hm,C_hm]=size(sk_hm);
    clus_hm(times_count)=R_hm;
    
    removal_threshold_sqm=1;
    [sk_sqm,sk_len_sqm,stand_cent_sqm,real_cent_sqm]=anomalous_pattern_kmeans(data1,y1,1,0,removal_threshold_sqm);
    [R_sqm,C_sqm]=size(sk_sqm);
    
    removal_threshold_mom=1;
    ym1=standard(data1,num_cate,wh_col,0,1);
    [sk_mom,sk_len_mom,stand_cent_mom,real_cent_mom]=anomalous_pattern_kmeans(data1,ym1,0,1,removal_threshold_mom);
    [R_mom,C_mom]=size(sk_mom);
    
    removal_threshold_sqm=1;
    [sk_sq_rm,sk_len_sq_rm,stand_cent_sq_rm,real_cent_sq_rm]=anomalous_pattern_kmeans(data1,y1,1,0,removal_threshold_sqm);
    [R_sq_rm,C_sq_rm]=size(sk_sq_rm);
    while R_sq_rm>=R_hm*1.15
        removal_threshold_sqm=removal_threshold_sqm+1;
        [sk_sq_rm,sk_len_sq_rm,stand_cent_sq_rm,real_cent_sq_rm]=anomalous_pattern_kmeans(data1,y1,1,0,removal_threshold_sqm);
        [R_sq_rm,C_sq_rm]=size(sk_sq_rm);
    end
    remove_thres_sqm(times_count)=removal_threshold_sqm;
    clus_sq_rm(times_count)=R_sq_rm;

    %     for i=1:R_sq
    %         stand_cent_sq(i,:)
    %         y(sk_sq(i,1:sk_len_sq(i))',:)
    %     end

    removal_threshold_mom=1;
    ym1=standard(data1,num_cate,wh_col,0,1);
    [sk_mo_rm,sk_len_mo_rm,stand_cent_mo_rm,real_cent_mo_rm]=anomalous_pattern_kmeans(data1,ym1,0,1,removal_threshold_mom);
    [R_mo_rm,C_mo_rm]=size(sk_mo_rm);
    while R_mo_rm>=R_hm*1.15
        removal_threshold_mom=removal_threshold_mom+1;
        [sk_mo_rm,sk_len_mo_rm,stand_cent_mo_rm,real_cent_mo_rm]=anomalous_pattern_kmeans(data1,ym1,0,1,removal_threshold_mom);
        [R_mo_rm,C_mo_rm]=size(sk_mo_rm);
    end
    remove_thres_mom(times_count)=removal_threshold_mom;
    clus_mo_rm(times_count)=R_mo_rm;
    
    
    %     for i=1:R_mo
    %         stand_cent_mo(i,:)
    %         y(sk_mo(i,1:sk_len_mo(i))',:)
    %     end   
    

    sk_len_sqm,sk_len_mom
    sk_len_sq_rm,sk_len_mo_rm
    removal_threshold_sqm,removal_threshold_mom
    sk_len_hm
    real_cent_sqm,real_cent_mom,real_cent_sq_rm,real_cent_mo_rm,real_cent_hm
end

%%%%%contigency table%%%%%%
con_table_1=zeros(R_sq,R_sqm);
for iii=1:R_sq
    for jjj=1:R_sqm
        count=0;
        for kkk=1:sk_len_sq(iii)
            for lll=1:sk_len_sqm(jjj)
                if sk_sq(iii,kkk)==sk_sqm(jjj,lll)
                    count=count+1;
                end
            end
        end
        con_table_1(iii,jjj)=count;
    end
end

con_table_2=zeros(R_h,R_hm);
for iii=1:R_h
    for jjj=1:R_hm
        count=0;
        for kkk=1:sk_len_h(iii)
            for lll=1:sk_len_hm(jjj)
                if sk_h(iii,kkk)==sk_hm(jjj,lll)
                    count=count+1;
                end
            end
        end
        con_table_2(iii,jjj)=count;
    end
end

con_table_3=zeros(R_mo,R_mom);
for iii=1:R_mo
    for jjj=1:R_mom
        count=0;
        for kkk=1:sk_len_mo(iii)
            for lll=1:sk_len_mom(jjj)
                if sk_mo(iii,kkk)==sk_mom(jjj,lll)
                    count=count+1;
                end
            end
        end
        con_table_3(iii,jjj)=count;
    end
end

con_table_1,con_table_2,con_table_3
