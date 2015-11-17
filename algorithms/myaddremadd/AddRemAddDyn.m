function [clustMembers, critValue, DebugInfo] = AddRemAddDyn(A)

%% Initializations
critValue = 0;
DebugInfo = struct('A', sparse(triu(A,1)), 'i', 0, 'clustMembers', [], 'attr', 0, 'av_crit', 0, 'semi_av_crit', 0, 'sum_crit', 0);
clustMembers = {};

%% Run
objectNum = size(A,1);


% [b, temp]  = max(A);
b = zeros(1, objectNum);
n = ones(1, objectNum);

%
clMem = num2cell(logical(speye(objectNum)),1);
% for i=1:objectNum
%     clMem{i}(temp(i)) = 1;
%     n(i) = nnz(clMem{i});
% end

%% Dynamical part

% for k=1:objectNum
%     for i=1:objectNum
%         [b(i), temp] = max([b(i),...
%             ~clMem{i}(k) * ((n(i)./(n(i)+1)) * b(i) + (2./(n(i)+1)) * sum(A(clMem{i}, k))),...
%             clMem{i}(k) * ((n(i)./(n(i)-1)) * b(i) - (2./(n(i)-1)) * sum(A(clMem{i}, k)))]);
%         switch temp
%             case 2
%                 clMem{i}(k) = 1;
%                 n(i) = n(i) +1;
%             case 3
%                 clMem{i}(k) = 0;
%                 n(i) = n(i) -1;
%         end
%     end
% end


% for k=1:objectNum
%     for i=1:objectNum
%         for j=1:objectNum
%             [b(i), temp] = max([b(i),...
%                 ~clMem{i}(k) * ((n(i)./(n(i)+1)) * b(i) + (2./(n(i)+1)) * sum(A(clMem{i}, k))),...
%                 clMem{i}(j) * ((n(i)./(n(i)-1)) * b(i) - (2./(n(i)-1)) * sum(A(clMem{i}, j)))]);
%             switch temp
%                 case 2
%                     clMem{i}(k) = 1;
%                     n(i) = n(i) +1;
%                     break;
%                 case 3
%                     clMem{i}(j) = 0;
%                     n(i) = n(i) -1;
%                     break
%             end
%         end
%     end
% end

[~, temp] =max(b);

clustMembers = clMem{temp};
DebugInfo.clustMembers = clustMembers;
[DebugInfo.attr, DebugInfo.av_crit, DebugInfo.semi_av_crit, DebugInfo.sum_crit] = CalcClusterPower(A, clustMembers);
critValue = DebugInfo.semi_av_crit;


%         if(~clMem{i}(k))
%             [b(i), temp] = max([b(i), (n(i)./(n(i)+1)) * b(i) + (2./(n(i)+1)) * sum(A(clMem{i}, k))]);
%             clMem{i}(k) = temp-1;
%             n(i) = n(i) + temp-1;
%         end