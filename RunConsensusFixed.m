function Results = RunConsensusFixed(DataArr, ConsFuncList)
% Function performs consensus functions over Ensemles stores in DataArr
% Input:
% DataArr - cell-array of structs
%   * .X - initial data [object x feature] matrix
%   * .truth - initial labels double vector
%   * .clNum - number of clusters (double)
%   * .Ensemble - cell-array of produced ensembles
%   * .ExperimentSchemes - struct of SchemeParams
% ConsensusList -  cell-array with the following structure:
%   * Consensus Algorithm Name (string)
%   * Algorithm Execution File (string of function handle);
%   * Parameters (struct)
%
% Result - cell-array of structures
%   * .sol - [object x experiments] matrix of consensus cluster labels
%   * .ari - [1 x experiments] vector of corresponding ARI indices
%   * .nmi - [1 x experiments] vector of corresponding NMI indices
%   * .acc - [1 x experiments] vector of corresponding Acciracy indices
%   * .cclNum - [1 x experiments] vector of number of consensus clusers

numFunc = size(ConsFuncList,1);
numData = size(DataArr,1);

% Initialization of output entity..
Results = cell(numData, numFunc);
for idata = 1:numData
    numObjects = size(DataArr{idata}.truth,1);
    for ifunc = 1:numFunc
        numExper = length(DataArr{idata}.Ensemble);        
        Results{idata, ifunc} = struct('sol', NaN(numObjects, numExper), 'ari', NaN(1,numExper),...
            'nmi', NaN(1, numExper), 'acc', NaN(1, numExper),...
            'cclNum', NaN(1, numExper)...
            );
    end
end

for idata = 1:numData
    numExper = length(DataArr{idata}.Ensemble);        
    fprintf('***** DataSet %d of %d *****\n', idata, numData);
    for iExp = 1:numExper;
        fprintf('-- Experiment %d of %d....\n', iExp, numExper);
        [A, P, I, C, S, AS] = BuildEnsembleFormatsFixed(DataArr{idata}.Ensemble{iExp});
        for ifunc = 1:numFunc
            tic
            fprintf('--- Starting %s...\n', ConsFuncList{ifunc,1});
            
            % Special for LinkCLue
            if strcmp(ConsFuncList{ifunc,1}, 'LinkClueCTS') ||...
                    strcmp(ConsFuncList{ifunc,1}, 'LinkClueSRS') ||...
                    strcmp(ConsFuncList{ifunc,1}, 'Bayes');
                ConsFuncList{ifunc,3}.K = length(unique(DataArr{idata}.truth));
            end
            
            switch(ConsFuncList{ifunc,3}.InputType)            
                case 'consmatrx'
                    Results{idata, ifunc}.sol(:,iExp) = feval(ConsFuncList{ifunc,2}, A, ConsFuncList{ifunc,3});
                    
                case 'cts'
                    Results{idata, ifunc}.sol(:,iExp) = feval(ConsFuncList{ifunc,2}, C, ConsFuncList{ifunc,3});
                
                case 'srs'
                    Results{idata, ifunc}.sol(:,iExp) = feval(ConsFuncList{ifunc,2}, S, ConsFuncList{ifunc,3});
                    
                case 'asrs'
                    Results{idata, ifunc}.sol(:,iExp) = feval(ConsFuncList{ifunc,2}, AS, ConsFuncList{ifunc,3});    
                    
                case 'pmatrx'
                    Results{idata, ifunc}.sol(:,iExp) = feval(ConsFuncList{ifunc,2}, P, ConsFuncList{ifunc,3});
                    
                case 'incds'
                    Results{idata, ifunc}.sol(:,iExp) = feval(ConsFuncList{ifunc,2}, I, ConsFuncList{ifunc,3});
                    
                case 'ensmbl'
                    Results{idata, ifunc}.sol(:,iExp) = feval(ConsFuncList{ifunc,2}, DataArr{idata}.Ensemble{iExp}, ConsFuncList{ifunc,3});
            end
            toc
            Results{idata, ifunc}.ari(iExp) = calculateARI(Results{idata, ifunc}.sol(:,iExp), DataArr{idata}.truth);
            Results{idata, ifunc}.nmi(iExp) = calculateNMI(Results{idata, ifunc}.sol(:,iExp), DataArr{idata}.truth);
            Results{idata, ifunc}.acc(iExp) = calculateAccuracy(Results{idata, ifunc}.sol(:,iExp), DataArr{idata}.truth);
            Results{idata, ifunc}.cp(iExp) = valid_compactness(DataArr{idata}.X, Results{idata, ifunc}.sol(:,iExp));
%             [Results{idata, ifunc}.db(iExp),...
%             Results{idata, ifunc}.dunn(iExp)] = valid_DbDunn(DataArr{idata}.X, Results{idata, ifunc}.sol(:,iExp));
            Results{idata, ifunc}.cclNum(iExp) = length(unique(Results{idata, ifunc}.sol(:,iExp)));
        end        
    end
end