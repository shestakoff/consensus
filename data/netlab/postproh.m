function postpro(times_count)
m_sq=load('m_sqt.dat');m_mo=load('m_mot.dat');m_j=load('m_jt.dat');m_a=load('m_at.dat');m_h=load('m_ht.dat');m_c=load('m_ct.dat');m_s=load('m_st.dat');m_d=load('m_dt.dat');
T_sq=load('T_sqt.dat');T_mo=load('T_mot.dat');T_j=load('T_jt.dat');T_a=load('T_at.dat');T_h=load('T_ht.dat');T_c=load('T_ct.dat');T_s=load('T_st.dat');T_d=load('T_dt.dat');
aver_overlap_sq=load('aver_overlap_sqt.dat');aver_overlap_mo=load('aver_overlap_mot.dat');aver_overlap_j=load('aver_overlap_jt.dat');aver_overlap_a=load('aver_overlap_at.dat');aver_overlap_h=load('aver_overlap_ht.dat');aver_overlap_c=load('aver_overlap_ct.dat');aver_overlap_s=load('aver_overlap_st.dat');aver_overlap_d=load('aver_overlap_dt.dat');
ari_sq=load('ari_sqt.dat');ari_mo=load('ari_mot.dat');ari_j=load('ari_jt.dat');ari_a=load('ari_at.dat');ari_h=load('ari_ht.dat');ari_c=load('ari_ct.dat');ari_s=load('ari_st.dat');ari_d=load('ari_dt.dat');
adc_sq_eucli=load('adc_sq_euclit.dat');adc_mo_eucli=load('adc_mo_euclit.dat');adc_j_eucli=load('adc_j_euclit.dat');adc_a_eucli=load('adc_a_euclit.dat');adc_h_eucli=load('adc_h_euclit.dat');adc_c_eucli=load('adc_c_euclit.dat');adc_s_eucli=load('adc_s_euclit.dat');adc_d_eucli=load('adc_d_euclit.dat');
adc_sq_man=load('adc_sq_mant.dat');adc_mo_man=load('adc_mo_mant.dat');adc_j_man=load('adc_j_mant.dat');adc_a_man=load('adc_a_mant.dat');adc_h_man=load('adc_h_mant.dat');adc_c_man=load('adc_c_mant.dat');adc_s_man=load('adc_s_mant.dat');adc_d_man=load('adc_d_mant.dat');
clus_sq=load('clus_sqt.dat');clus_mo=load('clus_mot.dat');clus_j=load('clus_jt.dat');clus_a=load('clus_at.dat');clus_h=load('clus_ht.dat');clus_c=load('clus_ct.dat');clus_s=load('clus_st.dat');clus_d=load('clus_dt.dat');
del=load('del.dat');
m_sq=m_sq(51:times_count);m_mo=m_mo(51:times_count);m_j=m_j(51:times_count);m_a=m_a(51:times_count);m_h=m_h(51:times_count);m_c=m_c(51:times_count);m_s=m_s(51:times_count);m_d=m_d(51:times_count);
T_sq=T_sq(51:times_count);T_mo=T_mo(51:times_count);T_j=T_j(51:times_count);T_a=T_a(51:times_count);T_h=T_h(51:times_count);T_c=T_c(51:times_count);T_s=T_s(51:times_count);T_d=T_d(51:times_count);
aver_overlap_sq=aver_overlap_sq(51:times_count);aver_overlap_mo=aver_overlap_mo(51:times_count);aver_overlap_j=aver_overlap_j(51:times_count);aver_overlap_a=aver_overlap_a(51:times_count);aver_overlap_h=aver_overlap_h(51:times_count);aver_overlap_c=aver_overlap_c(51:times_count);aver_overlap_s=aver_overlap_s(51:times_count);aver_overlap_d=aver_overlap_d(51:times_count);
ari_sq=ari_sq(51:times_count);ari_mo=ari_mo(51:times_count);ari_j=ari_j(51:times_count);ari_a=ari_a(51:times_count);ari_h=ari_h(51:times_count);ari_c=ari_c(51:times_count);ari_s=ari_s(51:times_count);ari_d=ari_d(51:times_count);
adc_sq_eucli=adc_sq_eucli(51:times_count);adc_mo_eucli=adc_mo_eucli(51:times_count);adc_j_eucli=adc_j_eucli(51:times_count);adc_a_eucli=adc_a_eucli(51:times_count);adc_h_eucli=adc_h_eucli(51:times_count);adc_c_eucli=adc_c_eucli(51:times_count);adc_s_eucli=adc_s_eucli(51:times_count);adc_d_eucli=adc_d_eucli(51:times_count);
adc_sq_man=adc_sq_man(51:times_count);adc_mo_man=adc_mo_man(51:times_count);adc_j_man=adc_j_man(51:times_count);adc_a_man=adc_a_man(51:times_count);adc_h_man=adc_h_man(51:times_count);adc_c_man=adc_c_man(51:times_count);adc_s_man=adc_s_man(51:times_count);adc_d_man=adc_d_man(51:times_count);
clus_sq=clus_sq(51:times_count);clus_mo=clus_mo(51:times_count);clus_j=clus_j(51:times_count);clus_a=clus_a(51:times_count);clus_h=clus_h(51:times_count);clus_c=clus_c(51:times_count);clus_s=clus_s(51:times_count);clus_d=clus_d(51:times_count);

compare_table_mean_tmp1=[mean(m_sq);mean(m_mo);mean(m_j);mean(m_a);mean(m_h);mean(m_c);mean(m_s);mean(m_d)];
compare_table_mean_tmp2=[mean(T_sq);mean(T_mo);mean(T_j);mean(T_a);mean(T_c);mean(T_c);mean(T_s);mean(T_d)];
compare_table_mean_tmp3=[mean(aver_overlap_sq);mean(aver_overlap_mo);mean(aver_overlap_j);mean(aver_overlap_a);mean(aver_overlap_h);mean(aver_overlap_c);mean(aver_overlap_s);mean(aver_overlap_d)];
compare_table_mean_tmp4=[mean(adc_sq_eucli);mean(adc_mo_eucli);mean(adc_j_eucli);mean(adc_a_eucli);mean(adc_h_eucli);mean(adc_c_eucli);mean(adc_s_eucli);mean(adc_d_eucli)];
compare_table_mean_tmp5=[mean(adc_sq_man);mean(adc_mo_man);mean(adc_j_man);mean(adc_a_man);mean(adc_h_man);mean(adc_c_man);mean(adc_s_man);mean(adc_d_man)];
compare_table_mean_tmp6=[mean(ari_sq);mean(ari_mo);mean(ari_j);mean(ari_a);mean(ari_h);mean(ari_c);mean(ari_s);mean(ari_d)];
compare_table=[compare_table_mean_tmp1,compare_table_mean_tmp2,compare_table_mean_tmp3,compare_table_mean_tmp4,compare_table_mean_tmp5,compare_table_mean_tmp6];
compare_table_std_tmp1=[std(m_sq,1);std(m_mo,1);std(m_j,1);std(m_a,1);std(m_h,1);std(m_c,1);std(m_s,1);std(m_d,1)];
compare_table_std_tmp2=[std(T_sq,1);std(T_mo,1);std(T_j,1);std(T_a,1);std(T_h,1);std(T_c,1);std(T_s,1);std(T_d,1)];
compare_table_std_tmp3=[std(aver_overlap_sq,1);std(aver_overlap_mo,1);std(aver_overlap_j,1);std(aver_overlap_a,1);std(aver_overlap_h,1);std(aver_overlap_c,1);std(aver_overlap_s,1);std(aver_overlap_d,1)];
compare_table_std_tmp4=[std(adc_sq_eucli,1);std(adc_mo_eucli,1);std(adc_j_eucli,1);std(adc_a_eucli,1);std(adc_h_eucli,1);std(adc_c_eucli,1);std(adc_s_eucli,1);std(adc_d_eucli,1)];
compare_table_std_tmp5=[std(adc_sq_man,1);std(adc_mo_man,1);std(adc_j_man,1);std(adc_a_man,1);std(adc_h_man,1);std(adc_c_man,1);std(adc_s_man,1);std(adc_d_man,1)];
compare_table_std_tmp6=[std(ari_sq,1);std(ari_mo,1);std(ari_j,1);std(ari_a,1);std(ari_h,1);std(ari_c,1);std(ari_s,1);std(ari_d,1)];
compare_table_std=[compare_table_std_tmp1,compare_table_std_tmp2,compare_table_std_tmp3,compare_table_std_tmp4,compare_table_std_tmp5,compare_table_std_tmp6];
clus=[clus_sq,clus_mo,clus_j,clus_h,clus_c,clus_a,clus_s,clus_d];m=[m_sq,m_mo,m_j,m_h,m_c,m_a,m_s,m_d];T=[T_sq,T_mo,T_j,T_h,T_c,T_a,T_s,T_d];aver_overlap=[aver_overlap_sq,aver_overlap_mo,aver_overlap_j,aver_overlap_h,aver_overlap_c,aver_overlap_a,aver_overlap_s,aver_overlap_d];adc_eucli=[adc_sq_eucli,adc_mo_eucli,adc_j_eucli,adc_h_eucli,adc_c_eucli,adc_a_eucli,adc_s_eucli,adc_d_eucli];adc_man=[adc_sq_man,adc_mo_man,adc_j_man,adc_h_man,adc_c_man,adc_a_man,adc_s_man,adc_d_man];ari=[ari_sq,ari_mo,ari_j,ari_h,ari_c,ari_a,ari_s,ari_d];,
clus=clus';m=m';T=T';aver_overlap=aver_overlap';ari=ari';adc_eucli=adc_eucli';adc_man=adc_man';
m_table=zeros(8,8);t_table=zeros(8,8);aver_table=zeros(8,8);adceu_table=zeros(8,8);adcma_table=zeros(8,8);ari_table=zeros(8,8);
for i=1:times_count-50
    for j=1:8
        for k=1:8
            if ari(j,i)>ari(k,i)
                ari_table(j,k)=ari_table(j,k)+1;
            elseif ari(j,i)<ari(k,i)
                ari_table(k,j)=ari_table(k,j)+1;
            end
            if m(j,i)<m(k,i)
                m_table(j,k)=m_table(j,k)+1;
            elseif m(j,i)>m(k,i)
                m_table(k,j)=m_table(k,j)+1;
            end
            if T(j,i)>T(k,i)
                t_table(j,k)=t_table(j,k)+1;
            elseif T(j,i)<T(k,i)
                t_table(k,j)=t_table(k,j)+1;
            end
            if aver_overlap(j,i)>aver_overlap(k,i)
                aver_table(j,k)=aver_table(j,k)+1;
            elseif aver_overlap(j,i)<aver_overlap(k,i)
                aver_table(k,j)=aver_table(k,j)+1;
            end
            if adc_eucli(j,i)<adc_eucli(k,i)
                adceu_table(j,k)=adceu_table(j,k)+1;
            elseif adc_eucli(j,i)>adc_eucli(k,i)
                adceu_table(k,j)=adceu_table(k,j)+1;
            end
            if adc_man(j,i)<adc_man(k,i)
                adcma_table(j,k)=adcma_table(j,k)+1;
            elseif adc_man(j,i)>adc_man(k,i)
                adcma_table(k,j)=adcma_table(k,j)+1;
            end
        end
    end
end
aver_table=aver_table/2;adceu_table=adceu_table/2;adcma_table=adcma_table/2;t_table=t_table/2;m_table=m_table/2;ari_table=ari_table/2;
text_priors=['delta of the priors: ' num2str(mean(del)) '/' num2str(std(del)) ]

text=['  ' '# clusters ' '   adc Euclidean   ' '     adc Manhanttan      ' '         T     ' '     ARI       ''      M      ''     Average Overlap ']
text_right_sq=['LS: '];
text_right_mo=['LM: '];
text_right_js=['JS: '];
text_right_af=['CD: '];
text_right_hk=['HK: '];
text_right_ck=['CH: '];
text_right_sw=['SW: '];
text_right_d=['DD: '];
table_text_sq=[num2str(mean(clus_sq)) '/' num2str(std(clus_sq)) '  ' num2str(compare_table(1,4)) '/'  num2str(compare_table_std(1,4)) '  ' num2str(compare_table(1,5)) '/'  num2str(compare_table_std(1,5)) ' ' num2str(compare_table(1,2)) '/'  num2str(compare_table_std(1,2)) '  ' num2str(compare_table(1,6)) '/'  num2str(compare_table_std(1,6)) '  ' num2str(compare_table(1,1)) '/'  num2str(compare_table_std(1,1)) '  '  num2str(compare_table(1,3)) '/'  num2str(compare_table_std(1,3))];
table_text_mo=[num2str(mean(clus_mo)) '/' num2str(std(clus_mo)) '  ' num2str(compare_table(2,4)) '/'  num2str(compare_table_std(2,4)) '  ' num2str(compare_table(2,5)) '/'  num2str(compare_table_std(2,5)) ' ' num2str(compare_table(2,2)) '/'  num2str(compare_table_std(2,2)) '  ' num2str(compare_table(2,6)) '/'  num2str(compare_table_std(2,6)) '  ' num2str(compare_table(2,1)) '/'  num2str(compare_table_std(2,1)) '  '  num2str(compare_table(2,3)) '/'  num2str(compare_table_std(2,3))];
table_text_j=[num2str(mean(clus_j)) '/' num2str(std(clus_j)) '  ' num2str(compare_table(3,4)) '/'  num2str(compare_table_std(3,4)) '  '  num2str(compare_table(3,5)) '/'  num2str(compare_table_std(3,5)) ' ' num2str(compare_table(3,2)) '/'  num2str(compare_table_std(3,2)) '  ' num2str(compare_table(3,6)) '/'  num2str(compare_table_std(3,6)) '  ' num2str(compare_table(3,1)) '/'  num2str(compare_table_std(3,1)) '  '  num2str(compare_table(3,3)) '/'  num2str(compare_table_std(3,3))];
table_text_a=[num2str(mean(clus_a)) '/' num2str(std(clus_a)) '  ' num2str(compare_table(4,4)) '/'  num2str(compare_table_std(4,4)) '  '  num2str(compare_table(4,5)) '/'  num2str(compare_table_std(4,5)) ' ' num2str(compare_table(4,2)) '/'  num2str(compare_table_std(4,2)) '  ' num2str(compare_table(4,6)) '/'  num2str(compare_table_std(4,6)) '  ' num2str(compare_table(4,1)) '/'  num2str(compare_table_std(4,1)) '  '  num2str(compare_table(4,3)) '/'  num2str(compare_table_std(4,3))];
table_text_h=[num2str(mean(clus_h)) '/' num2str(std(clus_h)) '  ' num2str(compare_table(5,4)) '/'  num2str(compare_table_std(5,4)) '  '  num2str(compare_table(5,5)) '/'  num2str(compare_table_std(5,5)) ' ' num2str(compare_table(5,2)) '/'  num2str(compare_table_std(5,2)) '  ' num2str(compare_table(5,6)) '/'  num2str(compare_table_std(5,6)) '  ' num2str(compare_table(5,1)) '/'  num2str(compare_table_std(5,1)) '  '  num2str(compare_table(5,3)) '/'  num2str(compare_table_std(5,3))];
table_text_c=[num2str(mean(clus_c)) '/' num2str(std(clus_c)) '  ' num2str(compare_table(6,4)) '/'  num2str(compare_table_std(6,4)) '  '  num2str(compare_table(6,5)) '/'  num2str(compare_table_std(6,5)) ' ' num2str(compare_table(6,2)) '/'  num2str(compare_table_std(6,2)) '  ' num2str(compare_table(6,6)) '/'  num2str(compare_table_std(6,6)) '  ' num2str(compare_table(6,1)) '/'  num2str(compare_table_std(6,1)) '  '  num2str(compare_table(6,3)) '/'  num2str(compare_table_std(6,3))];
table_text_s=[num2str(mean(clus_s)) '/' num2str(std(clus_s)) '  ' num2str(compare_table(7,4)) '/'  num2str(compare_table_std(7,4)) '  '  num2str(compare_table(7,5)) '/'  num2str(compare_table_std(7,5)) ' ' num2str(compare_table(7,2)) '/'  num2str(compare_table_std(7,2)) '  ' num2str(compare_table(7,6)) '/'  num2str(compare_table_std(7,6)) '  ' num2str(compare_table(7,1)) '/'  num2str(compare_table_std(7,1)) '  '  num2str(compare_table(7,3)) '/'  num2str(compare_table_std(7,3))];
table_text_d=[num2str(mean(clus_d)) '/' num2str(std(clus_d)) '  ' num2str(compare_table(8,4)) '/'  num2str(compare_table_std(8,4)) '  '  num2str(compare_table(8,5)) '/'  num2str(compare_table_std(8,5)) ' ' num2str(compare_table(8,2)) '/'  num2str(compare_table_std(8,2)) '  ' num2str(compare_table(8,6)) '/'  num2str(compare_table_std(8,6)) '  ' num2str(compare_table(8,1)) '/'  num2str(compare_table_std(8,1)) '  '  num2str(compare_table(8,3)) '/'  num2str(compare_table_std(8,3))];
text_sum_sq=[text_right_sq,table_text_sq]
text_sum_mo=[text_right_mo,table_text_mo]
text_sum_j=[text_right_js,table_text_j]
text_sum_h=[text_right_hk,table_text_h]
text_sum_c=[text_right_ck,table_text_c]
text_sum_a=[text_right_af,table_text_a]
text_sum_s=[text_right_sw,table_text_s]
text_sum_d=[text_right_d,table_text_d]
%con_table_sq,con_table_mo,con_table_j,con_table_h,con_table_c,con_table_a,con_table_s
adceu_sum=[adceu_table,sum(adceu_table,2)],sum(adceu_table,1),adcma_sum=[adcma_table,sum(adcma_table,2)],sum(adcma_table,1),t_sum=[t_table,sum(t_table,2)],sum(t_table,1),ari_sum=[ari_table,sum(ari_table,2)],sum(ari_table,1),m_sum=[m_table,sum(m_table,2)],sum(m_table,1),aver_sum=[aver_table,sum(aver_table,2)],sum(aver_table,1),