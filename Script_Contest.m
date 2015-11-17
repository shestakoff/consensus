%% Sandbox script for consensus contest framework

%% Parameters and framework initialization

Options.DataDir = './data/';
Options.ConsensusDir = './algorithms/';
Options.UtilsDir = './utils/';
Options.EnsembleSrcFuncsDir = './ensmblsrc/';
Options.ResultsDir = './results/';
Options.XlsDir = './results/';
Options.SaveFileName = 'Experiments_Generated_EQ_k12-prop-close';
Options.DrawResults = 0;
Options.ExportResults = 0;
datePoint = strrep(datestr(now),':','-');

FrameInit(Options)

%% Datasets Loader
DatasetList = GetGeneratedDatasetList(Options);
% DatasetList = GetGeneratedPartitionDatasetList(Options);
% DatasetList = GetArtificialDatasetList(Options);
% DatasetList = GetRealDatasetList(Options);

DataArr = LoadData(DatasetList);

%% Consensus Functions
ConsFuncList = GetConsensusFuncList();

%% Ensemble Parameters
ExperimentSchemesParams = GetGeneratedExperSchemeParams();
% ExperimentSchemesParams = GetGeneratedPartitionExperExperSchemeParams();
% ExperimentSchemesParams = GetArtificialExperSchemeParams();
% ExperimentSchemesParams = GetRealExperSchemeParams();

ExperimentSchemes = GetExperimentSchemes(DataArr, ExperimentSchemesParams);

%% Build Ensemble

DataArr = AddEnsemble(DataArr, ExperimentSchemes);

%% Run Consensus Algorithms

Results = RunConsensusFixed(DataArr, ConsFuncList);

%% Saving the whole crap staff
save([Options.ResultsDir Options.SaveFileName '_' datePoint '.mat'], 'Results', 'ExperimentSchemes', 'DataArr', 'DatasetList', 'ConsFuncList');

%% Drawing Results

if(Options.DrawResults)
    DrawParams.Dir = [Options.ResultsDir Options.SaveFileName '_' datePoint '/'];
    DrawExperimentResults(Results, DataArr, ConsFuncList, DrawParams);
end

%% Export to XLS
if(Options.ExportResults)
    ExportParams.FileName = [Options.XlsDir Options.SaveFileName '_' datePoint '.xls'];
    ExportResultsToXls(Results, DataArr, ExperimentSchemes, ConsFuncList, ExportParams)
end

