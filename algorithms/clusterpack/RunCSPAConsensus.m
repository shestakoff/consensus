function CSPAConsensus = RunCSPAConsensus(E, Params)
% Function performs CSPA consensus clustering scheme.
% Read corresponding paper of strehl and ghosh for details
% ClusterPack Software needed
% !!!! metis and smetis binaries and executables should be copied to MATLAB .\bin directory!!!
% Params is supposed to be empty and present here just to be in account with format

%% Run
CSPAConsensus = cspa(E');