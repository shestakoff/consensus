function [clustIncidence, DebugInfo] = ARA_All_Graph(A, Params)
% Function performs AddRemAdd algorithms over all objects iteratevely

if(~isfield(Params, 'ClusterExtractionMode'))
    Params.ClusterExtractionMode = 'Partitional';
end

if(~isfield(Params,'Diagonal'))
    Params.Diagonal = 0;
end

objNum = size(A,1);
clustIncidence = sparse(objNum,objNum);
objInd = 1:objNum;
curClustNum = 0;
DebugInfo = cell(objNum,1);

while(~isempty(A))
    curClustNum = curClustNum + 1;
    critValue = zeros(objNum,1);
    clustMembers = cell(objNum,1);
    
    siSize = NaN(objNum,1);
    for i = 1:objNum        
        siSize(i) = sum(A(i,:));
    end
    [~, i] = max(siSize);
    si = find(A(i,:)>0);
    si = union(si,i);
    
    if(Params.Diagonal)
        for i = 1:objNum
            [clustMembers{i}, critValue(i), Info(i)] = AddRemAdd_Diag(A,si);
        end
    else
        for i = 1:objNum
            [clustMembers{i}, critValue(i), Info(i)] = AddRemAdd(A,si);
        end
    end
    [~, iMax] = max(critValue);
    
    switch(Params.ClusterExtractionMode)
        case 'Partitional'
            A(clustMembers{iMax}, :) = [];
            A(:, clustMembers{iMax}) = [];
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
    
    objNum = size(A,1);
end

clustIncidence = clustIncidence(:,any(clustIncidence));
DebugInfo(cellfun(@isempty,(DebugInfo))) = [];