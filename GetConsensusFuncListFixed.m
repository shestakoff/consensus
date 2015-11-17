function ConsFuncList = GetConsensusFuncListFixed(k)
% Standalone function for Consensus List Building
% ConsensusList -  cell-array with the following structure:
%   * Consensus Algorithm Name (string)
%   * Algorithm Execution File (string of function handle);
%   * Parameters (struct)
%       ** Each Algorithm MUST have InputType Parameter!!!!

%%
ConsFuncParams = [];
ConsFuncParams.ARAallParams.InputType = 'consmatrx';
ConsFuncParams.ARAallParams.LabelFormat = 1;
ConsFuncParams.ARAallParams.SimilatiryMatrixPreprocess.Subtract = 'mean';
ConsFuncParams.ARAallParams.SimilatiryMatrixPreprocess.ClearDiagonal = 0;
ConsFuncParams.ARAallParams.AlgorithmParams.Diagonal = 1;
ConsFuncParams.ARAallParams.IterationScheme.IterationSchemeName = 'ARA_Fast';
ConsFuncParams.ARAallParams.IterationScheme.IterationSchemeFunc = @ARA_Fast;
ConsFuncParams.ARAallParams.AlgorithmParams.ClusterExtractionMode = 'Partitional';
ConsFuncParams.ARAallParams.AlgorithmParams.ClusterNumLimit = k;
ConsFuncList = {...
                'ARA\_All\_mean\_noClDiag\_Diag', @RunAddRemAddScheme, ConsFuncParams.ARAallParams;...
               };
           
%%
ConsFuncParams.ARAallParams = [];
ConsFuncParams.ARAallParams.InputType = 'cts';
ConsFuncParams.ARAallParams.LabelFormat = 1;
ConsFuncParams.ARAallParams.SimilatiryMatrixPreprocess.Subtract = 'mean';
ConsFuncParams.ARAallParams.SimilatiryMatrixPreprocess.ClearDiagonal = 0;
ConsFuncParams.ARAallParams.AlgorithmParams.Diagonal = 1;
ConsFuncParams.ARAallParams.IterationScheme.IterationSchemeName = 'ARA_Fast';
ConsFuncParams.ARAallParams.IterationScheme.IterationSchemeFunc = @ARA_Fast;
ConsFuncParams.ARAallParams.AlgorithmParams.ClusterExtractionMode = 'Partitional';
ConsFuncParams.ARAallParams.AlgorithmParams.ClusterNumLimit = k;

ConsFuncList = [ConsFuncList;...
                {'ARA\_All\_CTS\_mean\_noClDiag\_Diag', @RunAddRemAddScheme, ConsFuncParams.ARAallParams;}...
               ];           
   
%%            

ConsFuncParams.AddionsParams.InputType = 'consmatrx';
ConsFuncParams.AddionsParams.SimilatiryMatrixPreprocess.Subtract = 'mean';

ConsFuncParams.AddionsRParams.InputType = 'consmatrx';
ConsFuncParams.AddionsRParams.SimilatiryMatrixPreprocess.Subtract = 'random';

ConsFuncParams.BordaParams.InputType = 'ensmbl';

ConsFuncParams.CondorsetParams.InputType = 'ensmbl';

ConsFuncParams.CVoteParams.InputType = 'ensmbl';

ConsFuncParams.FutTransParams.InputType = 'ensmbl';

ConsFuncParams.VoteParams.InputType = 'ensmbl';

ConsFuncParams.MCLAParams.InputType = 'ensmbl';

ConsFuncParams.HGPAParams.InputType = 'ensmbl';

ConsFuncParams.CSPAParams.InputType = 'ensmbl';

ConsFuncParams.BCEParams.InputType = 'ensmbl';
ConsFuncParams.BCEParams.K = k;

ConsFuncParams.linkClueCTSParams.InputType = 'cts';
ConsFuncParams.linkClueCTSParams.Linkage = 'average';
ConsFuncParams.linkClueCTSParams.K = k;

ConsFuncParams.linkClueSRSParams.InputType = 'srs';
ConsFuncParams.linkClueSRSParams.Linkage = 'average';
ConsFuncParams.linkClueSRSParams.K = k;

ConsFuncList = [...
                ConsFuncList;...
                {...
% %                 'Addions', @RunAddionsPScheme, ConsFuncParams.AddionsParams;...
% %                 'AddionsR', @RunAddionsPScheme, ConsFuncParams.AddionsRParams;...
% %                 'Borda', @RunBordaScheme, ConsFuncParams.BordaParams;...
% %                 'MCLA', @RunMCLAConsensus, ConsFuncParams.MCLAParams;...
% %                 'CSPA', @RunCSPAConsensus, ConsFuncParams.CSPAParams;...
% %                 'HGPA', @RunHGPAConsensus, ConsFuncParams.HGPAParams;...
% %                 'Condorse', @RunCondorsetScheme, ConsFuncList.CondorsetParams;...
% %                 'CVote', @RunCvoteConsensus, ConsFuncParams.CVoteParams;...
% %                 'FutureTransfer', @RunFutTransScheme, ConsFuncList.FutTransParams;...
% %                 'Vote', @RunVoteConsensus, ConsFuncParams.VoteParams;...
                'Bayes', @RunBCEScheme, ConsFuncParams.BCEParams;...
                'LinkClueCTS', @linkClueCTSScheme, ConsFuncParams.linkClueCTSParams;...
                'LinkClueSRS', @linkClueSRSScheme, ConsFuncParams.linkClueSRSParams;...
                }... 
                ];