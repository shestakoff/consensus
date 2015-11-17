function y=standard(data,l,col_cate,least_square,least_moduli)
[R,C]=size(data);
if least_square==1
    gm=sum(data)/R;
elseif least_moduli==1
    gm=median(data);
end
av=repmat(gm,R,1);
if l==0 & col_cate==0
    y=(data-av);
else
    y=(data-av);
    for i=1:C
        for j=1:l
            if i==col_cate(j)
                y(:,col_cate(j))=y(:,col_cate(j))./sqrt(l);
            end
        end
    end
end