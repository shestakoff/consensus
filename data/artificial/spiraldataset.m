clear 
close all

h=0.2;
phi=1.5:h:20;
a=10;
x=a.*phi.*sin(phi);
y=a.*phi.*cos(phi);
p=ones(size(x));

x1=a.*(phi).*sin(-phi);
y1=a.*(-phi).*cos(-phi);

p=[p,2.*ones(size(x1))];
plot(x,y,'*r');
hold on
plot(x1,y1,'*b');

X=[x,x1;y,y1]';
reallabels=p';
n=size(X,1);

st=std(X);
m=mean(X);
X=(X-repmat(m,n,1))./repmat(st,n,1);

e=1;
l=9;


%% Поехалии
kk=randi([2,4],1,l);% кол-во кластеров в k-means
kkstat(1,e)=mean(kk);
kkstat(2,e)=std(kk);    


%% Применяем K-Means составления разбиений
% try
CP=[];
ConsensusPartitionsNames={};       
E=[];
d=[];
sumd=[];
C=[];
for i=1:l
[E(:,i),C{i,1},d]=kmeans(X,kk(1,i),'emptyaction','drop');
sumd(i,1)=sum(d);
end
%  catch exception 
%      fprintf('***********************************************\n-!!!! Experiment #%d: Error with k-means. Retry... !!!!-\n***********************************************\n',e); 
%  continue; 
% end
disp('Ensemble constructed....');

[temp,idx]=min(sumd);
KMpartition=E(:,idx);
CP=[CP,KMpartition];
ConsensusPartitionsNames=[ConsensusPartitionsNames,'best k-means'];

figure;
for i=1:l
    subplot(3,3,i)
    hold on;
    for j=1:max(E(:,i))
        if(j==1)
            plot(X(E(:,i)==j,1),X(E(:,i)==j,2),'*b');
        elseif(j==2)
            plot(X(E(:,i)==j,1),X(E(:,i)==j,2),'*r');
        elseif(j==3)
            plot(X(E(:,i)==j,1),X(E(:,i)==j,2),'*g');
        elseif(j==4)
            plot(X(E(:,i)==j,1),X(E(:,i)==j,2),'*k');
        end
    end
end
    
    
%% Смотрим ARI и NMI reallabels с разбиениями в k-means
for p=1:l
    ARIreal_k(p)=ARI(E(:,p),reallabels);
end
AvARIreal_k(e,1)=mean(ARIreal_k);

for p=1:l
    NMIreal_k(p)=NMI(E(:,p),reallabels);
end
AvNMIreal_k(e,1)=mean(NMIreal_k);

fprintf('Average ARI(RealLabels,K-means Partitions): %g\nAverage NMI(RealLabels,K-means Partitions): %g\n\n',AvARIreal_k(e,1),AvNMIreal_k(e,1));
% if AvARIreal_k(e,1)<0.5 || AvARIreal_k(e,1)>0.71
%     fprintf('***********************************************\n-!!!! Experiment #%d: Unsuitable AARI. Retry... !!!!-\n***********************************************\n',e); 
% continue
% end

 
%% Поехали консенсус

 
%% Строим матрицы связей 2-х типов
tic
[A,P]=matr(E);
toc; disp(' ');

%% Handmade agglomerative algorithm №2
tic
AgglomerativeConsensusP=aggl(P - l/n);
toc; disp(' ');
CP=[CP,AgglomerativeConsensusP];
ConsensusPartitionsNames=[ConsensusPartitionsNames,'Aggl_P'];

%% AddRemAdd nonoverlap with A
tic
AddRemAddConsensusA2=addremadd2(A/l);
toc; disp(' ');
CP=[CP,AddRemAddConsensusA2];
ConsensusPartitionsNames=[ConsensusPartitionsNames,'ARA_A'];

%% Объединяем все разбиения
CP=[CP,reallabels];
ConsensusPartitionsNames=[ConsensusPartitionsNames,'Real'];

%% Считаем NMI с настоящим разбиением объектов и со всеми разбиениями

disp('Calculating NMI ANMI ARI AARI...');

ConsNum=size(CP,2);

ANMIindex(e,:)=zeros(1,ConsNum);
for p=1:ConsNum
    NMIindex(e,p)=NMI(CP(:,p),reallabels); 
    for i=1:l
        ANMIindex(e,p)=ANMIindex(e,p)+NMI(CP(:,p),E(:,i));
    end
end
ANMIindex(e,:)=ANMIindex(e,:)/l;

%% Считаем ARI с настоящим разбиением

ConsNum=size(CP,2);

AvARIindex(e,:)=zeros(1,ConsNum);
for p=1:ConsNum
    ARIindex(e,p)=ARI(CP(:,p),reallabels);   
    for i=1:l
        AvARIindex(e,p)=AvARIindex(e,p)+ARI(CP(:,p),E(:,i));
    end
end
 AvARIindex(e,:)= AvARIindex(e,:)/l;

%% Считаем количество классов

 for i=1:ConsNum;
     CPk(e,i)=length(unique(CP(:,i)));
 end
 
 
%% Смотрим

disp('DONE!');

figure;
imagesc (CP); figure(gcf);

figure;
hold on;
    for j=1:max(reallabels)
        if(j==1)
            plot(X(reallabels==j,1),X(reallabels==j,2),'*b');
        elseif(j==2)
            plot(X(reallabels==j,1),X(reallabels==j,2),'*r');
        elseif(j==3)
            plot(X(reallabels==j,1),X(reallabels==j,2),'*g');
        elseif(j==4)
            plot(X(reallabels==j,1),X(reallabels==j,2),'*k');
        elseif(j==5)
            plot(X(reallabels==j,1),X(reallabels==j,2),'*c');
        end
    end

% run('C:\Users\Shestakoff\Dropbox\IV курс\ВКР\demonstrator.m')