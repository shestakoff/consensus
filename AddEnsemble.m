function DataArr = AddEnsemble(DataArr, ExperimentSchemes)
% Function add ensemble, for each dataset in DataArr based on
% ExperimentSchemes and store it in DataArr
% Output:
% DataArr - cell-array of structs
%   * .X - initial data [object x feature] matrix
%   * .truth - initial labels double vector
%   * .Ensemble - cell-array of produced ensembles
%   * .ExperimentSchemes - struct of SchemeParams

numData = length(DataArr); % number of schemes is the same\

for idata = 1:numData
    fprintf('***** Adding Ensembles for Dataset %d of %d *****\n', idata, numData);
    DataArr{idata}.Ensemble = BuildEnsemble(DataArr{idata}.X, DataArr{idata}.truth, ExperimentSchemes{idata});
    DataArr{idata}.ExperimentScheme = ExperimentSchemes{idata};
    DataArr{idata}.EnsembleARI = NaN(DataArr{idata}.ExperimentScheme.ExperimentsNum, 1);
    for iExp = 1:DataArr{idata}.ExperimentScheme.ExperimentsNum
        aritemp = 0;
        numPart = sum(DataArr{idata}.ExperimentScheme.EnsembleSize);
        for ipart = 1:numPart
            aritemp = aritemp + calculateARI(DataArr{idata}.Ensemble{iExp}(:, ipart), DataArr{idata}.truth);
        end
        DataArr{idata}.EnsembleARI(iExp) = aritemp./numPart;
    end
end
