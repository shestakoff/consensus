% intelligent universal K-Means (interpreting aids provided)
% with loading the datfile parameter
% the number of classes can be prespecified, initial seeds are found with 
% Mirkin's AP algorithm;
% seeds may be prespecified as entities

clear all;

global  nn mm yvar yyvar X me range distance sharevar file;
global min max scatter contributions doy sst;
datain;% input of data
[X,yyvar]=Excvar(X,yvar);% eliminating variables if needed

threshold=input('Input cluster cardinality to discard ');
%Y=num2cell(yyvar,2);
%Z=ones(size(Y));

[nn,mm]=size(X) 


nuc=input('Input the limit to the number of clusters if you have one or "enter".  ');
if isempty(nuc)
    numofclus=nn;
else
    numofclus=nuc;
end;

[me, range,min,max]=stand(X);
%[me, range,min,max]=standmas(X);

doy=input('Do you want objects as tentative centroids (y)? ', 's');

	remains=1:nn;
	distance=dist(X,remains, me);
	contributions=contrib(X,remains,me,range);
	scatter=sum(distance);
	scatcon=sum(contributions);
if ~strcmp(doy,'y')
    dis=distance;% parameters in the algorithm
	scatterac=0;
	number=0;

	while [~(isempty(remains))& (number<numofclus)]

	  %	number=number+1;
  		[d,ind]=max(dis);
	  	index=remains(ind);
  		centroid=X(index,:);
  		key=1;

		  while key==1;
      		cluster=separ(remains,centroid);
      		newcenter=center(cluster);
        			if ~isequal(centroid, newcenter)
           			centroid=newcenter;
        			else
           			key=0;
        			end;
  			end;
  		if length(cluster)>threshold
           	number=number+1;
            centers(number,:)=centroid;
            cluset{number}=cluster;
        end;
            remains=setdiff(remains, cluster);
  		    dis=distance(remains);
    end;
else
   for nnu=1:numofclus
      an=input(['What entity for ' num2str(nnu) '-th centroid?  ']);
      centers(nnu,:)=X(an,:);
   end;
end;


list=parkmeans(X,centers)
ak=length(list);
scatterac=0;
for number=1:ak
   cluster=list{number};
   Clusters{number,1}=cluster;
   centroid=center(cluster);
   censtand=(centroid-me)./range;
  [c,cn,sccl]=eucsq(centroid,me);
  scatcl=sccl*length(cluster)/scatter;
  Clusters{number,2}=[centroid;cn;censtand];
  scatterac=scatterac+scatcl;
  Clusters{number,3}=[scatcl, scatterac];
  clcon=c.*c;
  relat=clcon./contributions;
  relcon=relat*(100*scatcon/sccl);
  Clusters{number,4}=round(relcon);
end;  

  
Clusters
ss=input( 'Do you want save the result: y|n ? ', 's');
if ss=='y'
  Clisave; %saving clustering results
end;
return
