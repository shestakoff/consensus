function DatasetList = GetRealDatasetList(Options)
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

DataParams.GlassParams.Dir = [Options.DataDir 'uci/glass/'];
DataParams.GlassParams.Centering = 1;
DataParams.GlassParams.Normalization = 1;

DataParams.HeartParams.Dir = [Options.DataDir 'uci/heart/'];
DataParams.HeartParams.Centering = 1;
DataParams.HeartParams.Normalization = 1;

DataParams.HepatitisParams.Dir = [Options.DataDir 'uci/hepatitis/'];
DataParams.HepatitisParams.Centering = 1;
DataParams.HepatitisParams.Normalization = 1;

DataParams.IonosphereParams.Dir = [Options.DataDir 'uci/ionosphere/'];
DataParams.IonosphereParams.Centering = 1;
DataParams.IonosphereParams.Normalization = 1;

% % DataParams.SegmantationParams.Dir = [Options.DataDir 'uci/segmantation/'];
% % DataParams.SegmantationParams.Centering = 1;
% % DataParams.SegmantationParams.Normalization = 1;

DataParams.WineParams.Dir = [Options.DataDir 'uci/wine/'];
DataParams.WineParams.Centering = 1;
DataParams.WineParams.Normalization = 1;

DataParams.YeastParams.Dir = [Options.DataDir 'uci/yeast/'];
DataParams.YeastParams.Centering = 1;
DataParams.YeastParams.Normalization = 1;


DatasetList = {...    
% 'Iris_eq' @irisLoader, DataParams.IrisParams;...
% 'Iris_rand' @irisLoader, DataParams.IrisParams;...
% 
% 'Australian_eq' @australianLoader, DataParams.AustralianParams;...
% 'Australian_rand' @australianLoader, DataParams.AustralianParams;...
% 
% 'Balance_eq' @balanceLoader, DataParams.BalanceParams;...
% 'Balance_rand' @balanceLoader, DataParams.BalanceParams;...
% 
'Breast_eq' @breastcancerLoader, DataParams.BreastParams;...
'Breast_rand' @breastcancerLoader, DataParams.BreastParams;...
% 
% 'Diabetes_eq' @diabetesLoader, DataParams.DiabetesParams;...
% 'Diabetes_rand' @diabetesLoader, DataParams.DiabetesParams;...
% 
% 'Glass_eq' @glassLoader, DataParams.GlassParams;...
% 'Glass_rand' @glassLoader, DataParams.GlassParams;...

'Heart_eq' @heartLoader, DataParams.HeartParams;...
'Heart_rand' @heartLoader, DataParams.HeartParams;...
% 
% % 'Hepatitis_eq' @hepatitisLoader, DataParams.HepatitisParams;...
% % 'Hepatitis_rand' @hepatitisLoader, DataParams.HepatitisParams;...
% 
'Ionosphere_eq' @ionosphereLoader, DataParams.IonosphereParams;...
'Ionosphere_rand' @ionosphereLoader, DataParams.IonosphereParams;...
% 
% % 'Segmantation_eq' @segmantationLoader, DataParams.SegmantationParams;...
% % 'Segmantation_rand' @segmantationLoader, DataParams.SegmantationParams;...
% 
% 'Wine_eq' @wineLoader, DataParams.WineParams;...
% 'Wine_rand' @wineLoader, DataParams.WineParams;...
% 
% 'Yeast_eq' @yeastLoader, DataParams.YeastParams;...
% 'Yeast_rand' @yeastLoader, DataParams.YeastParams;...
};