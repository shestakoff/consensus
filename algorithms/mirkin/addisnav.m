% sequential extraction of clusters, addisnav.m from a
% similarity matrix B, transformed first by subtracting
% value B=B-aver, and then into P=(B+B')/2;
% however, contributions are counted over nonsymmetric B, whose scatter is
% scattera
% in contrast to addis.m, takes nonoverlapping clusters (by operating on
% remainder set only)

function [labels, contrib, intensity,ff]=addisnav(B,aver)

global scattera;

% A is assumed to have no diagonal: 
[nn,nn]=size(B);
    A=B-aver;
    for ii=1:nn
        A(ii,ii)=0;
    end;
    sc=A.*A;
    scattera=sum(sum(sc));
    ff=[1:nn];%this is the set to get clusters from
    flag=1;
    tt=1;
    At=A;
    accu=0;
    while flag>0
        %collecting a cluster cl, with its contrib con and intensity inten
        [clin, con, inten]=addions(At);
     
        if length(clin)>1
            cl=ff(clin);
            Bt=B(cl,cl);
            clusters{tt}=cl;
            contrib(tt)=(con*100)/scattera;
            accu=accu+contrib(tt);
            intensity(tt)=inten;
        %pause
            tt=tt+1;
            ff=setdiff(ff,cl);
            At=A(ff,ff);
            if length(ff)<=1
                flag=0;
            end;
        else
            flag=0;
        end;
    end;
    
    labels=zeros(nn,1);
    for i=1:length(clusters)
        labels(clusters{i})=i;
    end

    %fle=['Result\' dataf num2str(aver) '.res'];
    % saveladc(fle, clusters,ff,intensity)
return