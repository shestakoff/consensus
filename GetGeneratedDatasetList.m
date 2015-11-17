function DatasetList = GetGeneratedDatasetList(Options)
% Standalone function for DatasetList setting
% DatasetList -  cell-array with the following structure:
%   * Dataset Name (string)
%   * Dataset Loading File(string of function handle);
%   * Parameters (struct)

DataParams.GenParams.numFeatures = 15;
DataParams.GenParams.numClusters = Options.ClusterNum;
DataParams.GenParams.numObjects = 1500;
switch(Options.ClusterCardinalities)
    case 'eq'
        DataParams.GenParams.clustCardinalities = 'eq';
    case 'rand'
        DataParams.GenParams.clustCardinalities = 'eq';
    case 'fixed'
        if Options.ClusterNum == 7
            DataParams.GenParams.clustCardinalities = [0.5 0.3 0.04 0.04 0.04 0.04 0.04];
        elseif Options.ClusterNum == 12
            DataParams.GenParams.clustCardinalities = [0.3 0.2 0.1 0.08 0.04 0.04 0.04 0.04 0.04 0.04 0.04 0.04];
        else
            DataParams.GenParams.clustCardinalities = [0.3 0.2 0.04 0.04 0.04 0.04 0.04 0.04 0.04 0.04 0.018 0.018 0.018 0.018 0.018 0.018 0.018 0.018 0.018 0.018];
        end
end

DataParams.GenParams.Sigma = 0.3;
DataParams.GenParams.SigmaShift = 0.1;
DataParams.GenParams.Discenter = Options.Coef;
DataParams.GenParams.CovarType = 'diag2';

DatasetList = {...
                'Generated' @generatedLoader, DataParams.GenParams;...
                'Generated' @generatedLoader, DataParams.GenParams;...
                'Generated' @generatedLoader, DataParams.GenParams;...
                'Generated' @generatedLoader, DataParams.GenParams;...
                'Generated' @generatedLoader, DataParams.GenParams;...
                'Generated' @generatedLoader, DataParams.GenParams;...
                'Generated' @generatedLoader, DataParams.GenParams;...
                'Generated' @generatedLoader, DataParams.GenParams;...
                'Generated' @generatedLoader, DataParams.GenParams;...
                'Generated' @generatedLoader, DataParams.GenParams;...
                };