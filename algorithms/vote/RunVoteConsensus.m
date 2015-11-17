function VoteConsensus=RunVoteConsensus(E, Params)
% Function performs VotingScheme consensus clustering scheme.
% Params is supposed to be empty and present here just to be in account with format

%% Run
VoteConsensus = vote(E);