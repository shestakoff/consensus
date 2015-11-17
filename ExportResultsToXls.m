function ExportResultsToXls(Results, DataArr, ExperimentSchemes, ConsFuncList, Params)

numFunc = size(ConsFuncList,1);
numData = size(DataArr,1);
FuncNames = ConsFuncList(:,1)';

for idata = 1:numData
    numExper = ExperimentSchemes{idata}.ExperimentsNum;
    DataSetName = [DataArr{idata}.name '_' int2str(idata)];
    RawExportMatrixLabels = [{'ARI', 'Experiment #'}, FuncNames];
    RawExportMatrix = cell(numExper , length(RawExportMatrixLabels));
    RawExportMatrix(:,2) = num2cell([1:numExper]');
    
    InfoExportMatrix = cell(3 , length(RawExportMatrixLabels)); 
    InfoExportMatrix{1,1} = 'True Number of Clusters';
    InfoExportMatrix{1,2} = DataArr{idata}.clNum;
    InfoExportMatrix{2,1} = 'Ensemble Size';
    InfoExportMatrix{2,2} = ExperimentSchemes{idata}.EnsembleSize;
    InfoExportMatrix{3,1} = 'Objects Num';
    InfoExportMatrix{3,2} = length(DataArr{idata}.truth);
    
    ClustNumExportMatrixLabels = [{'ClassNum', 'Experiment #'}, FuncNames];
    ClustNumExportMatrix = cell(numExper , length(ClustNumExportMatrixLabels));
    ClustNumExportMatrix(:,2) = num2cell([1:numExper]');
    if numExper > 1
        RawStatExportMatrix = cell(2, length(RawExportMatrixLabels));
        RawStatExportMatrix{1,2} = 'Average';
        RawStatExportMatrix{2,2} = 'Std';
    end
    
    for ifunc = 1:numFunc
        icol = strcmp(RawExportMatrixLabels, ConsFuncList{ifunc,1});
        RawExportMatrix(:,icol) = num2cell(Results{idata, ifunc}.ari');
        ClustNumExportMatrix(:,icol) = num2cell(Results{idata, ifunc}.cclNum');
        if numExper > 1
            RawStatExportMatrix{1,icol} = nanmean(Results{idata, ifunc}.ari);
            RawStatExportMatrix{2,icol} = nanstd(Results{idata, ifunc}.ari);
        end
    end
    
    if numExper > 1
        ResultExportMatrix = [InfoExportMatrix;...
            cell(2, length(RawExportMatrixLabels));...
            RawExportMatrixLabels; RawExportMatrix;...
            RawStatExportMatrix;...
            cell(2, length(RawExportMatrixLabels));...
            ClustNumExportMatrixLabels; ClustNumExportMatrix;...
            ];
    else
        ResultExportMatrix = [InfoExportMatrix;...
            cell(2, length(RawExportMatrixLabels));...
            RawExportMatrixLabels; RawExportMatrix;...
            cell(2, length(RawExportMatrixLabels));...
            ClustNumExportMatrixLabels; ClustNumExportMatrix;...
            ];
    end
    xlswrite(Params.FileName, ResultExportMatrix, DataSetName);
end

end