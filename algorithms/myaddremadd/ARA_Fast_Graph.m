function [clustIncidence, DebugInfo] = ARA_Fast_Graph(A, Params)
% Function performs AddRemAdd algorithms starting from random object,
% finding optimal cluster and continue to another random object

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
    
    i = randi(objNum,1);
    si = find(A(i,:)>0);
    si = union(si,i);
    
    
    if(Params.Diagonal)
        [clustMembers, critValue, Info] = AddRemAdd_Diag(A,si);
    else
        [clustMembers, critValue, Info] = AddRemAdd(A,si);
    end
    
    
    switch(Params.ClusterExtractionMode)
        case 'Partitional'
            A(clustMembers, :) = [];
            A(:, clustMembers) = [];
            clustIncidence(objInd(clustMembers), curClustNum) = 1;
            objInd(clustMembers) = [];
        case 'Additive'
            if(strcmp(Params.ClusterExtractionStop,'ZeroCrit') &&  critValue==0)
                break
            end
            A(clustMembers, clustMembers) = A(clustMembers, clustMembers) - Info(i).av_crit;
            for i = 1:objNum
                A(i,i) = 0;
            end
            clustIncidence(objInd(clustMembers), curClustNum) = 1;
    end
    
    
    DebugInfo{curClustNum, 1} = Info;
    
    objNum = size(A,1);
end

clustIncidence = clustIncidence(:,any(clustIncidence));
DebugInfo(cellfun(@isempty,(DebugInfo))) = [];