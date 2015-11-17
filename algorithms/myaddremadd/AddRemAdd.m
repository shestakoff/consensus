function [clustMembers, critValue, DebugInfo] = AddRemAdd(A,si)
% Function performs calculation sequence of AddRemAdd algorithm to
% optimize semi-average criterion b(S). Initialization from object i
% b(S) = (S-1)*a(S), where a(S) = [1/S*(S-1)] * \sum_{i,j \in S} a_ij
%
% Input: 
% A - symmetric similarity matrix
% i - initial object index
%
% Output:
% clustMemb - intex vector of cluster members
% critValue - criterion value of result cluster
% DebugInfo - struct with additional information on clustering result

%% Initializations
critValue = 0;
DebugInfo = struct('A', [], 'i', si, 'clustMembers', [], 'attr', 0, 'av_crit', 0, 'semi_av_crit', 0, 'sum_crit', 0);

%% Run
objectNum = size(A,1);

z = -ones(objectNum,1); % index vector
z(si) = -z(si);

ak = NaN(objectNum, 1); % vector of average similarities of object to cluster
d = NaN(objectNum, 1); % vector of criterion derivations

temp = A(z==1,:);
temp(:,z==1) = NaN;
[aMax, iMax] = max(temp(:));
[~,iMax] = ind2sub(size(temp), iMax);
if(aMax <=0 || isnan(aMax))
    clustMembers = si;
    DebugInfo.clustMembers = clustMembers;
    [DebugInfo.attr, DebugInfo.av_crit, DebugInfo.semi_av_crit, DebugInfo.sum_crit] = CalcClusterPower(A, clustMembers);
    return
end

z(iMax) = -z(iMax);
s = length(si)+z(iMax); % cluster coordinaliry

ma = sum(sum(A(z==1,z==1)))./((s-1)*s); % average within clust simularity
iter = 1;

% figure;
% plot(iter,ma,'*');
% hold on;
% text(iter,ma,'2');

% objects similarity to cluster
ak(z==1) = sum(A(z==1,z==1))./(s-1); 
ak(z==-1) = sum(A(z==1,z==-1))./s;


%% Main iterations
while(1)
%     iter = iter + 1;
%     d = z.*((s + (z-1)./2)./(s - (z-1)./2).*ma - 2.*(s./(s - (z-1)./2)).*ak); % changes of criterion
    d = z.*(((s+z).*ma - 2.*(s + (z + 1)/2).*ak) ./ (s+1) );
    [dMax, iMax] = max(d);
    
    if(dMax <= 0 || isinf(dMax))
        clustMembers = find(z == 1);
        DebugInfo.clustMembers = clustMembers;
        [DebugInfo.attr, DebugInfo.av_crit, DebugInfo.semi_av_crit, DebugInfo.sum_crit] = CalcClusterPower(A, clustMembers);
        critValue = DebugInfo.semi_av_crit;
        return;
    else
        ma = ma + 2*z(iMax).*(ma - ak(iMax))./(s - (3*z(iMax)+1)./2);
%         plot(iter,(s - z(iMax)-1)*ma,'*');
%         text(iter,(s - z(iMax)-1)*ma,num2str(s - z(iMax)));
    end
    ak([1:iMax-1 iMax+1:end]) = ak([1:iMax-1 iMax+1:end]) + ...
        z(iMax).*(ak([1:iMax-1 iMax+1:end]) - A([1:iMax-1 iMax+1:end], iMax)) ./ (s - (z([1:iMax-1 iMax+1:end])+1)./2 - z(iMax));
    s = s - z(iMax);
    z(iMax) = -z(iMax);
    
end
