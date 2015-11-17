function [clustIncidence, DebugInfo] = ARA_All(A, Params)
% Function performs AddRemAdd algorithms over all objects iteratevely

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
    critValue = zeros(objNum,1);
    clustMembers = cell(objNum,1);
    
    if(Params.Diagonal)
        for i = 1:objNum
            [clustMembers{i}, critValue(i), Info(i)] = AddRemAdd_Diag(A(objInd,objInd),i);
        end
    else
        for i = 1:objNum
            [clustMembers{i}, critValue(i), Info(i)] = AddRemAdd(A(objInd,objInd),i);
        end
    end
    [~, iMax] = max(critValue);
    
    switch(Params.ClusterExtractionMode)
        case 'Partitional'
            %A(clustMembers{iMax}, :) = [];
            %A(:, clustMembers{iMax}) = [];
            clustIncidence(objInd(clustMembers{iMax}), curClustNum) = 1;
            objInd(clustMembers{iMax}) = [];
        case 'Additive'
            if(strcmp(Params.ClusterExtractionStop,'ZeroCrit') &&  critValue(iMax)==0)
                break
            end
            A(clustMembers{iMax},clustMembers{iMax}) = A(clustMembers{iMax},clustMembers{iMax}) - Info(iMax).av_crit;
            if(~Params.Diagonal)
            for i = clustMembers{iMax}'
                    A(i,i) = 0;
                end
            end
            clustIncidence(objInd(clustMembers{iMax}), curClustNum) = 1;
            
    end
    
    DebugInfo{curClustNum, 1} = Info(iMax);
    
    objNum = length(objInd);
end

clustIncidence = clustIncidence(:,any(clustIncidence));
DebugInfo(cellfun(@isempty,(DebugInfo))) = [];