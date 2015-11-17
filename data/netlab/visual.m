clear all;
global X nn mm yyvar yvar file;
file=input('input the name of your file.dat as file (no quotes) ', 's');
filename=[file '.dat'];
namfile=[file '.nam'];
%names=readlist(namfile);
X=load(filename);
[nn,mm]=size(X);
me=mean(X);
mmin=min(X);
mmax=max(X);
range=mmax-mmin;
for i=1:nn
    for j=1:mm
	Y(i,j)=(X(i,j)-me(j))/range(j); %---- no need to do scaling for students' marks
    end
end
TY=sum(sum(Y.*Y));
[a,la,b]=svd(Y);
z1=a(:,1)*sqrt(la(1,1));
z2=a(:,2)*sqrt(la(2,2));
c1=b(:,1);
c2=b(:,2);
mu1=la(1,1); disp('mu1 ');
mu2=la(2,2); disp('mu2 ');
x1=z1;
x2=z2;
%plot(z1,z2,'r.');
%text(z1,z2,names);
b1=[1:2];
b2=[3:7];
b3=[8:362];
b4=[363:410];
b5=[411:484];
b6=[485:495];
b7=[496:544];
b8=[545:797];
b9=[798:1000];
figure(2)
plot(x1(b1),x2(b1),'b+',x1(b2),x2(b2),'r^',x1(b3),x2(b3),'g.',x1(b4),x2(b4),'b.',x1(b5),x2(b5),'r+',x1(b6),x2(b6),'b*',x1(b7),x2(b7),'g+',x1(b8),x2(b8),'r+',x1(b9),x2(b9),'g*');
set(gca,'YTick',-0.5:0.1:0.5)
v=axis;
axis(1.5*v);