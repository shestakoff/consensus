function FrameInit(Options)
% Function performs some initializations of framework

addpath(genpath(Options.DataDir));
addpath(genpath(Options.ConsensusDir));
addpath(genpath(Options.UtilsDir));
addpath(genpath(Options.EnsembleSrcFuncsDir));

if(~exist(Options.ResultsDir,'dir'))
   mkdir(Options.ResultsDir); 
end