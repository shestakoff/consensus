function CondarsetConsensus = RunCondarsetScheme(E, Params)
% Function performs Condarset consensus clustering scheme.
% Params is supposed to be empty and present here just to be in account with format

%% Run

CondarsetConsensus=condor(E);

