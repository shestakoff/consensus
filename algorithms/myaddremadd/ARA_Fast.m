function [clustIncidence, DebugInfo] = ARA_Fast(A, Params)
% Function performs AddRemAdd algorithms starting from random object,
% finding optimal cluster and continue to another random object

if(~isfield(Params, 'ClusterExtractionMode'))
    Params.ClusterExtractionMode = 'Partitional';
end

if(~isfield(Params, 'ClusterNumLimit'))
    Params.ClusterNumLimit = inf;
end

if(~isfield(Params,'Diagonal'))
    Params.Diagonal = 0;
end

objNum = size(A,1);
clustIncidence = sparse(objNum,objNum);
objInd = (1:objNum)';
curClustNum = 0;
DebugInfo = cell(objNum,1);

while(~isempty(objInd))
    if curClustNum == Params.ClusterNumLimit
        clustIncidence = clustIncidence(:,any(clustIncidence));
        attr = zeros(objNum, curClustNum);
        for icl = 1:curClustNum
            attr(:, icl) = sum(A(objInd, find(clustIncidence(:,icl))), 2)./nnz(clustIncidence(:,icl)) ;
        end
        [~, clustInd] = max(attr,[],2);
        sind = sub2ind(size(clustIncidence), objInd, clustInd);
        clustIncidence(sind) = 1;
        break
    end
    
    curClustNum = curClustNum + 1;
    
    i = randi(objNum,1);
    
    if(Params.Diagonal)
        [clustMembers, critValue, Info] = AddRemAdd_Diag(A(objInd,objInd),i);
    else
        [clustMembers, critValue, Info] = AddRemAdd(A(objInd,objInd),i);
    end
    
    
    switch(Params.ClusterExtractionMode)
        case 'Partitional'
            %A(clustMembers{iMax}, :) = [];
            %A(:, clustMembers{iMax}) = [];
            clustIncidence(objInd(clustMembers), curClustNum) = 1;
            objInd(clustMembers) = [];
        case 'Additive'
            if(strcmp(Params.ClusterExtractionStop,'ZeroCrit') &&  critValue(1)==0)
                break
            end
            A(clustMembers, clustMembers) = A(clustMembers,clustMembers) - Info(1).av_crit;
            if(~Params.Diagonal)
            for i = clustMembers'
                    A(i,i) = 0;
                end
            end
            clustIncidence(objInd(clustMembers), curClustNum) = 1;     
    end
    
    DebugInfo{curClustNum, 1} = Info(1);
    
    objNum = length(objInd);
end

clustIncidence = clustIncidence(:,any(clustIncidence));
DebugInfo(cellfun(@isempty,(DebugInfo))) = [];