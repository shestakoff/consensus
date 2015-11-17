clear 
close all
n=200;

a1=randn(n/2,2);
a2=randn(n/2,2);
a3=randn(n/2,2);
reallabels=[repmat(1,n/2,1);repmat(2,n/2,1)];

s=sum(abs(a2),2);
b=(a2)./repmat(s,1,2);

c=-1.4*a3+12.*b;
a1=0.7.*a1;
%%
plot(a1(:,1),a1(:,2),'*r');
hold on
plot(c(:,1),c(:,2),'.b');
X=[a1;c];
%%
st=std(X);
m=mean(X);
X=(X-repmat(m,n,1))./repmat(st,n,1);

e=1;
l=100;


%% Поехалии
kk=randi([3,3],1,l);% кол-во кластеров в k-means
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
%%
figure;
for i=1:9
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


%% Применяем венгерский алгоритм для переобозначения
% Для расчета A и Р делать совсем не обязательно!
Ref=E(:,1); % выбираем ссылку
Erel=Relabeling(E,Ref);      
 
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

%% Voting Scheme
tic
VotingConsensus=vote(E);
toc; disp(' ');
CP=[CP,VotingConsensus];
ConsensusPartitionsNames=[ConsensusPartitionsNames,'Vot'];

%% Ayad cVote
tic
cVoteConsensus=cvote(E);
toc; disp(' ');
CP=[CP,cVoteConsensus];
ConsensusPartitionsNames=[ConsensusPartitionsNames,'cVote'];

%% FusionTransfer 
tic
FusionConsensus=ft(E,A,l);
toc; disp(' ');
CP=[CP,FusionConsensus];
ConsensusPartitionsNames=[ConsensusPartitionsNames,'Fus'];
    
%% Borda Consensus
tic
BordaConsensus=borda(Erel);
toc; disp(' ');
CP=[CP,BordaConsensus];
ConsensusPartitionsNames=[ConsensusPartitionsNames,'Borda'];


%% MCLA Consensus
tic
disp('MCLA algorithm starts....');
MCLAConsensus=mcla(E')';
toc; disp(' ');
CP=[CP,MCLAConsensus];
ConsensusPartitionsNames=[ConsensusPartitionsNames,'MCLA'];


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
%%
figure;
for i=2:8
subplot(2,4,i-1)
hold on;
    for j=1:max(CP(:,i))
        if(j==1)
            plot(X(CP(:,i)==j,1),X(CP(:,i)==j,2),'+b');
        elseif(j==2)
            plot(X(CP(:,i)==j,1),X(CP(:,i)==j,2),'or');
        elseif(j==3)
            plot(X(CP(:,i)==j,1),X(CP(:,i)==j,2),'*g');
        elseif(j==4)
            plot(X(CP(:,i)==j,1),X(CP(:,i)==j,2),'.k');
        elseif(j==5)
            plot(X(CP(:,i)==j,1),X(CP(:,i)==j,2),'sc');
        elseif(j==6)
            plot(X(CP(:,i)==j,1),X(CP(:,i)==j,2),'^y');
        elseif(j==7)
            plot(X(CP(:,i)==j,1),X(CP(:,i)==j,2),'pm');
        end
        title(ConsensusPartitionsNames{i});
    end
end
% run('C:\Users\Shestakoff\Dropbox\IV курс\ВКР\demonstrator.m')