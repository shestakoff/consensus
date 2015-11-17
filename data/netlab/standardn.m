function y=standardn(data,real,syn,l,col_cate,least_square,least_moduli)
[R,C]=size(data);
if least_square==1
    gm=(sum(real)/R)./(sum(syn)/R);
elseif least_moduli==1
    bb=sort(syn);csum=sum(syn,1)/2;
    for i=1:C
        aa=0;
        for j=1:R
            aa=aa+bb(j,i);
            if aa>=csum(1,i)
                gm(1,i)=data(j,i);break
            end
        end
    end
end
av=repmat(gm,R,1);
if l==0 & col_cate==0
    y=data-av;
else
    y=data-av;
    for i=1:C
        for j=1:l
            if i==col_cate(j)
                y(:,col_cate(j))=y(:,col_cate(j))./sqrt(l);
            end
        end
    end
end