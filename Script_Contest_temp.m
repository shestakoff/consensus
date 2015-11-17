%% Sandbox script for consensus contest framework
% cd = 'S:\Dropbox\II Master\Thesis_Bach\framework';

%% Parameters and framework initialization

Options.DataDir = './data/';
Options.ConsensusDir = './algorithms/';
Options.UtilsDir = './utils/';
Options.EnsembleSrcFuncsDir = './ensmblsrc/';
Options.ResultsDir = './results/';
Options.XlsDir = './results/';
Options.DrawResults = 0;
Options.ExportResults = 0;

datePoint = strrep(datestr(now),':','-');

fout = fopen([datePoint '.log'], 'w');

FrameInit(Options)

%% Params Arrs
Params = struct();

% % Gen data
% Params.DataType = {'generated'}; % 'generated', 'real1', 'real2', 'toy' 
% Params.ClusterNum = num2cell([12]);
% Params.ClusterCardinalities = {'rand', 'fixed', 'eq'};
% Params.IsEnsembleKEqual = num2cell([0, 1]);
% Params.IsKnownK = num2cell([1]);
% Params.Coef = num2cell([0.6, 1, 2]);

% % Partition data
% Params.DataType = {'partition'}; % 'generated', 'real1', 'real2', 'toy' 
% Params.ClusterNum = num2cell([7, 12, 20]);
% Params.ClusterCardinalities = {'0'};
% Params.IsEnsembleKEqual = num2cell([1]);
% Params.IsKnownK = num2cell([1]);
% Params.Coef = num2cell([0]);

% ToDo
% Real1 data
Params.DataType = {'real1'}; % 'generated', 'real1', 'real2', 'toy' 
Params.ClusterNum = num2cell([0]);
Params.ClusterCardinalities = {'0'};
Params.IsEnsembleKEqual = num2cell([1]);
Params.IsKnownK = num2cell([1]);
Params.Coef = num2cell([0]);

% ToDo
% Real2 data
% Params.DataType = {'real2'}; % 'generated', 'real1', 'real2', 'toy' 
% Params.ClusterNum = num2cell([0]);
% Params.ClusterCardinalities = {'0'};
% Params.IsEnsembleKEqual = num2cell([1]);
% Params.IsKnownK = num2cell([0, 1]);
% Params.Coef = num2cell([0]);

% ToDo
% % Toy data
% Params.DataType = {'toy'}; % 'generated', 'real1', 'real2', 'toy' 
% Params.ClusterNum = num2cell([0]);
% Params.ClusterCardinalities = {'0'};
% Params.IsEnsembleKEqual = num2cell([1]);
% Params.IsKnownK = num2cell([1]);
% Params.Coef = num2cell([0]);

Params = ParamsCartesian(Params);

for i = 1:length(Params)
    %% Data Params
    Options.DataType = Params(i).DataType;
    Options.ClusterNum = Params(i).ClusterNum;
    Options.Coef = Params(i).Coef; % 0.6, 1, 2
    Options.ClusterCardinalities = Params(i).ClusterCardinalities; % 'fixed, eq, rand
    
    %% Ensemble Params
    Options.IsEnsembleKEqual = Params(i).IsEnsembleKEqual;
    Options.LowerARI = 0.2;
    Options.UpperARI = 0.8;
    
    %% ConsAlgorithms Params
    Options.IsKnownK = Params(i).IsKnownK;
    
    %% Constructing file name
    Options.SaveFileName = sprintf('%s_Experiments_%s_clNum-%d_clCoef-%.2f_clCard-%s_ensKeq-%d_algKeq-%d', ...
        datePoint,...
        Options.DataType,...      
        Options.ClusterNum,...
        Options.Coef,...
        Options.ClusterCardinalities,...
        Options.IsEnsembleKEqual,...
        Options.IsKnownK);
    
    fprintf(fout, ['Running ' Options.SaveFileName '\n']);
    
    try
        
        %% Datasets Loader
        
        switch(Options.DataType)
            case 'generated'
                DatasetList = GetGeneratedDatasetList(Options);
            case 'partition'
                DatasetList = GetGeneratedPartitionDatasetList(Options);
            case 'toy'
                DatasetList = GetArtificialDatasetList(Options);
            case 'real1'
                DatasetList = GetRealDatasetList1(Options);
            case 'real2'
                DatasetList = GetRealDatasetList2(Options);
        end
        
        DataArr = LoadData(DatasetList);
        
        %% Consensus Functions
        if Options.IsKnownK
            ConsFuncList = GetConsensusFuncListFixed(Options.ClusterNum);
        else
            ConsFuncList = GetConsensusFuncList();
        end
        
        %% Ensemble Parameters
        switch(Options.DataType)
            case 'generated'
                ExperimentSchemesParams = GetGeneratedExperSchemeParams(Options);
            case 'partition'
                ExperimentSchemesParams = GetGeneratedPartitionExperExperSchemeParams(Options);
            case 'toy'
                ExperimentSchemesParams = GetArtificialExperSchemeParams();
            case 'real1'
                ExperimentSchemesParams = GetRealExperSchemeParams1(Options);
            case 'real2'
                ExperimentSchemesParams = GetRealExperSchemeParams2(Options);
        end
                
        ExperimentSchemes = GetExperimentSchemes(DataArr, ExperimentSchemesParams);
        
        %% Build Ensemble
        
        DataArr = AddEnsemble(DataArr, ExperimentSchemes);
        
        %% Run Consensus Algorithms
        
        Results = RunConsensus(DataArr, ConsFuncList, Options);
        
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
        
    catch ME
        fprintf(fout, ME.message);
        fprintf(fout, '\n');
    end
    %% Clear all
    clear Results ExperimentSchemes DataArr DatasetList ConsFuncList
end

fclose(fout);