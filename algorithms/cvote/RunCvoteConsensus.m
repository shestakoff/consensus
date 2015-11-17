function cVoteConsensus=RunCvoteConsensus(E, Params)
% Function performs Cvote consensus clustering scheme.
% Params is supposed to be empty and present here just to be in account with format

%% Run
cVoteConsensus=cvote(E);