function [clustIncidence, DebugInfo] = ARA_Dyn(A, Params)
% Function performs AddRemAdd algorithms over all objects iteratevely

if(~isfield(Params, 'ClusterExtractionMode'))
    Params.ClusterExtractionMode = 'Partitional';
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
    
    [clustMembers, critValue, Info] = AddRemAddDyn(A);
    
    switch(Params.ClusterExtractionMode)
        case 'Partitional'
            A(clustMembers, :) = [];
            A(:, clustMembers) = [];
            clustIncidence(objInd(clustMembers), curClustNum) = 1;
            objInd(clustMembers) = [];
        case 'Additive'
            if(strcmp(Params.ClusterExtractionStop,'ZeroCrit') &&  critValue(iMax)==0)
                break
            end
            A(clustMembers,clustMembers) = A(clustMembers,clustMembers) - Info(iMax).av_crit;
            for i = clustMembers'
                A(i,i) = 0;
            end
            clustIncidence(objInd(clustMembers), curClustNum) = 1;
            
    end
    
    DebugInfo{curClustNum, 1} = Info;
    
    objNum = size(A,1);
end

clustIncidence = clustIncidence(:,any(clustIncidence));
DebugInfo(cellfun(@isempty,(DebugInfo))) = [];