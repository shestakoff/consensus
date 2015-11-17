function [clustMembers, critValue, DebugInfo] = AddRemAdd_Diag(A,si)
% Function performs calculation sequence of AddRemAdd algorithm to
% optimize semi-average criterion b(S). Initialization from object i
% b(S) = (S)*a(S), where a(S) = [1/S^2] * \sum_{i,j \in S} a_ij
%
% Input: 
% A - symmetric similarity matrix A 
% i - initial object index
%
% Output:
% clustMemb - intex vector of cluster members
% critValue - criterion value of resut cluster
% DebugInfo - struct with additional information on clustering result

%% Initializations
critValue = 0;
DebugInfo = struct('A', [], 'i', si, 'clustMembers', [], 'attr', 0, 'av_crit', 0, 'semi_av_crit', 0, 'sum_crit', 0);

%% Run
objectNum = size(A,1);

z = -ones(objectNum,1); % index vector
z(si) = -z(si);

ak = NaN(objectNum, 1); % vector of average similarities of object to cluster
d = NaN(objectNum, 1); % vector of criterion derivatives

temp = A(z==1,:);
temp(:,z==1) = NaN;
[aMax, iMax] = max(temp(:));
[~,iMax] = ind2sub(size(temp), iMax);
if(aMax <=0 || isnan(aMax))
    clustMembers = si;
    DebugInfo.clustMembers = clustMembers;
    [DebugInfo.attr, DebugInfo.av_crit, DebugInfo.semi_av_crit, DebugInfo.sum_crit] = CalcClusterPower_diag(A, clustMembers);
    return
end

z(iMax) = -z(iMax);
s = length(si) + z(iMax); % cluster coordinaliry

ma = sum(sum(A(z==1,z==1)))./(s^2); % average within clust simularity
ba = ma*s; % semi-average similarity
iter = 1;

% figure;
% plot(iter,ba,'*');
% hold on;
% text(iter,ba,'2');

% objects similarity to cluster
ak(si) = sum(A(si,z==1))./s;
ak(iMax) = sum(A(iMax,z==1))./s;
ak(z==-1) = (A(si,z==-1) + A(iMax, z==-1))/s;

%% Main iterations
while(1)
%     iter = iter + 1;
%     d = z.*((s + (z-1)./2)./(s - (z-1)./2).*ma - 2.*(s./(s - (z-1)./2)).*ak); % changes of criterion
    d = z.*(ba - 2.*s.*ak + z.*diag(A))./(s - z);
    [dMax, iMax] = max(d);
    
    if(dMax <= 0 || isinf(dMax))
        clustMembers = find(z == 1);
        DebugInfo.clustMembers = clustMembers;
        [DebugInfo.attr, DebugInfo.av_crit, DebugInfo.semi_av_crit, DebugInfo.sum_crit] = CalcClusterPower_diag(A, clustMembers);
        critValue = DebugInfo.semi_av_crit;
        return;
    else
        ba = ba + dMax;
%         ma = ma + z(iMax).*(-2.*s.*ak(iMax) + z(iMax).*(A(iMax,iMax)) + 2.*(s - z(iMax)/2).*ma)./((s - z(iMax)).^2);
%         plot(iter,ba,'*');
%         text(iter,ba,num2str(s - z(iMax)));
    end
%    ak([1:iMax-1 iMax+1:end]) = ak([1:iMax-1 iMax+1:end]) + ...
%       z(iMax).*(ak([1:iMax-1 iMax+1:end]) - A([1:iMax-1 iMax+1:end],iMax))./(s - z(iMax));
    ak = ak + ...
        z(iMax).*(ak - A(:,iMax))./(s - z(iMax));
    s = s - z(iMax);
    z(iMax) = -z(iMax);
    
end
