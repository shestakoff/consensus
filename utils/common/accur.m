function [acc K] = accur(p1,p2)
% Реальное разбиение должно быть на втором месте!!
% Считаем коэффицент сходства Каппы. По формуле K=(Po-Pe)/(1-Pe), где Po
% наблюдаемая связь между разбиениями, а Pe - ожидаемая связь. Иначе
% говоря, Ро=сумма(наибольшие элементы в кросстабе по строчкам)/Общее
% количество элементов, а Ре сумма(элементов по строчкам и столбцам)/ общее
% число элементов.

crtab=crosstab(p1,p2);
K=zeros(2,2);
n=sum(sum(crtab));
K(2,2)=n;
% for i=1:size(crtab,1)
%     [m,jm]=max(crtab(i,:));
%     K(1,1)=K(1,1)+m;
%     
%     crtab(i,jm)=0;
%     K(2,1)=K(2,1)+sum(crtab(i,:));
%     K(1,2)=K(1,2)+sum(crtab(:,jm));
%     K(2,2)=K(2,2)-sum(crtab(i,:))-sum(crtab(:,jm))-m;
%     crtab(:,jm)=0.*crtab(:,jm);
%     crtab(i,:)=0.*crtab(i,:);
% end
while(1)
    [m,im]=max(crtab);
    [m,jm]=max(m);
    im=im(jm);
    if m==0
        break
    end
    K(1,1)=K(1,1)+m;
    
    crtab(im,jm)=0;
    K(2,1)=K(2,1)+sum(crtab(im,:));
    K(1,2)=K(1,2)+sum(crtab(:,jm));
    K(2,2)=K(2,2)-sum(crtab(im,:))-sum(crtab(:,jm))-m;
    crtab(:,jm)=0.*crtab(:,jm);
    crtab(im,:)=0.*crtab(im,:);
end


acc=K(1,1)/n;