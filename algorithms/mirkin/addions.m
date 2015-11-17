% addions.m finding a cluster ss over a
% similarity matrix At, whose contribution is cscatp,%
% for overlapping clustering in addis.m

function [fins, fc, inten]=addions(At)
global scattera;
% P is assumed have no diagonal (zeros stand there): criterion max f(S)
% with z_i=1 for i in S and z_i=-1 otherwise
% f(S)= sum_i_in_S a(i,S)/|S| 
% where a(i,S)=sum_j_in_S(a_{ij}) -(z_i+1)a_{ii}/2
% Delta(i)=-2z_i(a(i,S)-f(S)/2)/(|S|-z_i) is increase in f(S) with z_i to be reversed
%
%fins - cluster, fc its absolute contribution, inten, intensity

[nn,nn]=size(At);
P=(At+At')/2;
csc=[];
cli{1}=[];
%collecting a cluster starting from every entity ii
for ii=1:nn
    zz=ones(1,nn);
    zz=-zz;
    zz(ii)=1;
    %initial setting
    ali=P(ii,:);
    ali(ii)=0; % vector of all p(ii,jj), for jj= ii is zero
    [f,jj]=max(ali);
    if (f==0)
        cli{ii}=[ii];
        csc(ii)=0;
        int(ii)=0;
    else %this means: there are positive intensities yet
        fs=P(ii,jj);%initial summary average criterion f(S)
        ss=[ii jj];%set S
        zz(jj)=1;
        alj=P(jj,:);
        alj(jj)=0;
        ala=ali+alj;%summary similarity to S 
        ns=2;% #S
    %iteration of adding/ removing
        flag=1;
        while ((flag>0)&(ns>1))
            vych=fs/2;
            de=ala-vych;
            delta=zz.*de;
            delta=-2*delta;
            [md,idd]=max(delta);
            if md>0
                idd;%index of changing
                fs=fs+md/(ns-zz(idd)); %new criterion value
                zz(idd)=-zz(idd);%new belongingness
                ns=ns+zz(idd); %new cardinality
                post=ala(idd);
                ala=ala+zz(idd)*P(idd,:);
                ala(idd)=post;%new summary 
            else
                flag=-1;
            end;
        end;
        ss=find(zz==1);
        cli{ii}=ss;
        if length(ss)<=1
            disp('Wrong calculation ');
            pause;
        end;
        Cs=At(ss,ss);
    
        %Css=Cs.*Cs;
        sumcl=sum(sum(Cs));% scatter within the cluster
        la=sumcl*sumcl;
        car=length(ss)*(length(ss)-1);
        if ~(car==0)
            cld=la/car;
            csc(ii)=cld;
            int(ii)=sumcl/car;
        else
            csc(ii)=0;
            int(ii)=0;
        end;
    end;
end;

if length(csc)==0
    fins=[];
    inten=0;
    fc=0;
else
    [fc,fi]=max(csc);
    fins=cli{fi};
    inten=int(fi);
    fi;
    fc;
    csc;
end;
return