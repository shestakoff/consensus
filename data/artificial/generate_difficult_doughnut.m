function [A,true_labels] = generate_difficult_doughnut(N_per_cluster)
A = [];
i1 = randn(N_per_cluster,1)*0.55;
j1 = randn(N_per_cluster,1)*0.55;
for kk = 1:N_per_cluster
    r = rand; dummy1 = 5*sin(r*2*pi); dummy2 = 5*cos(r*2*pi);
    i2(kk) = dummy1-1.4*randn; j2(kk) = dummy2-1.4*randn;
end
A = [i1 j1;i2' j2']; A = [A rand(2*N_per_cluster,10)*4];
true_labels = [ones(N_per_cluster,1);ones(N_per_cluster,1)*2];

%=================%
%plot(A(:,1),A(:,2),'k.','markersize',20)
%axis square
%axis off
