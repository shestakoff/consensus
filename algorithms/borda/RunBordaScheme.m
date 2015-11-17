function BordaConsensus = RunBordaScheme(E, Params)
% Function performs Borda consensus clustering scheme.
% Params is supposed to be empty and present here just to be in account with format

%% Run

BordaConsensus=borda(E);

