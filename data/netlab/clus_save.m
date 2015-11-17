function clus_save(data,sk,sk_len,stand_cent,real_cent,least_square,least_moduli)
fid = fopen('data.nam', 'r');
i=1;
while feof(fid) == 0
   clus_name{i} = fgetl(fid);
   i=i+1;
end
fclose(fid);

[R,C]=size(data);
[R_sk,C_sk]=size(sk);
if least_square==1
    text0=[num2str(R) '    Entities     '];
    text1=[num2str(C) '    Features     \n\n'];
    text0=[text0 text1];
    method0=['Least Square Version Anomalous Pattern Intelligent K-means Clustering Algorithm \n'];
    fid=fopen('data_sq.res','w');
    fprintf(fid,text0);
    fprintf(fid,method0);
    for i=1:R_sk
        for j=1:sk_len(i)
            clus_list{i,j}=clus_name{sk(i,j)};
        end
    end
    for i=1:R_sk
        text2=['\n\nCluster ' num2str(i) '\n\n'];
        text3=[];
        for j=1:sk_len(i)
            text3=[text3 '  ' clus_list{i,j}];
        end
        text4=['\n\nStandard Centroids \n\n'];
        text5=num2str(stand_cent(i,:));
        text6=['\n\nReal Centroids \n\n'];
        text7=num2str(real_cent(i,:));
        fprintf(fid,text2);
        fprintf(fid,text3);
        fprintf(fid,text4);
        fprintf(fid,text5);
        fprintf(fid,text6);
        fprintf(fid,text7);
    end
    fclose(fid);
elseif least_moduli==1
    text0=[num2str(R) '    Entities     '];
    text1=[num2str(C) '    Features     \n\n'];
    text0=[text0 text1];
    method0=['Least moduli Version Anomalous Pattern Intelligent K-means Clustering Algorithm \n'];
    fid=fopen('data_mo.res','w');
    fprintf(fid,text0);
    fprintf(fid,method0);
    for i=1:R_sk
        for j=1:sk_len(i)
            clus_list{i,j}=clus_name{sk(i,j)};
        end
    end
    for i=1:R_sk
        text2=['\n\nCluster ' num2str(i) '\n\n'];
        text3=[];
        for j=1:sk_len(i)
            text3=[text3 '  ' clus_list{i,j}];
        end
        text4=['\n\nStandard Centroids \n\n'];
        text5=num2str(stand_cent(i,:));
        text6=['\n\nReal Centroids \n\n'];
        text7=num2str(real_cent(i,:));
        fprintf(fid,text2);
        fprintf(fid,text3);
        fprintf(fid,text4);
        fprintf(fid,text5);
        fprintf(fid,text6);
        fprintf(fid,text7);
    end
    fclose(fid);
end