function DatasetList = GetDatasetList(Options)
% Standalone function for DatasetList setting
% DatasetList -  cell-array with the following structure:
%   * Dataset Name (string)
%   * Dataset Loading File(string of function handle);
%   * Parameters (struct)

DataParams.IrisParams.Dir = [Options.DataDir 'uci/iris/'];
DataParams.IrisParams.Centering = 1;
DataParams.IrisParams.Normalization = 1;
DataParams.AustralianParams.Dir = [Options.DataDir 'uci/australian/'];
DataParams.AustralianParams.Centering = 1;
DataParams.AustralianParams.Normalization = 1;
DataParams.BalanceParams.Dir = [Options.DataDir 'uci/balance/'];
DataParams.BalanceParams.Centering = 1;
DataParams.BalanceParams.Normalization = 1;
DataParams.BreastParams.Dir = [Options.DataDir 'uci/breastcancer/'];
DataParams.BreastParams.Centering = 1;
DataParams.BreastParams.Normalization = 1;
DataParams.DiabetesParams.Dir = [Options.DataDir 'uci/diabetes/'];
DataParams.DiabetesParams.Centering = 1;
DataParams.DiabetesParams.Normalization = 1;
DataParams.IonosphereParams.Dir = [Options.DataDir 'uci/ionosphere/'];
DataParams.IonosphereParams.Centering = 1;
DataParams.IonosphereParams.Normalization = 1;
DataParams.SegmantationParams.Dir = [Options.DataDir 'uci/segmantation/'];
DataParams.SegmantationParams.Centering = 1;
DataParams.SegmantationParams.Normalization = 1;
DataParams.WineParams.Dir = [Options.DataDir 'uci/wine/'];
DataParams.WineParams.Centering = 1;
DataParams.WineParams.Normalization = 1;
DataParams.YeastParams.Dir = [Options.DataDir 'uci/yeast/'];
DataParams.YeastParams.Centering = 1;
DataParams.YeastParams.Normalization = 1;


DatasetList = {...
                    'Yeast_eq' @yeastLoader, DataParams.YeastParams;...
                    'Yeast_less' @yeastLoader, DataParams.YeastParams;...
                    'Yeast_gr' @yeastLoader, DataParams.YeastParams;...
                    'Yeast_rand' @yeastLoader, DataParams.YeastParams;...
    };