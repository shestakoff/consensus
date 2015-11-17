function [clustIncidence, DebugInfo] = RunAddRemAddScheme(A, Params)
% Function performs calculation AddRemAdd algorithm to
% optimize semi-average criterion b(S) initialized by some set of objects
% b(S) = (S-1)*a(S), where a(S) = [1/S*(S-1)] * \sum_{i,j \in S} a_ij
% or
% b(S) = (S)*a(S), where a(S) = [1/S^2)] * \sum_{i,j \in S} a_ij
% in diagonal case
%
% Input:
% A - symmetric similarity matrix A
% i - initial object index
% Params - structure with parameters
%
% Output:
% clustIncidence - matrix of cluster belongings (objects x clusters)
% DebugInfo - struct with additional information on clustering result

%% Initializations
A = (A + A')./2;
objNum = size(A,1);
clustIncidence = [];
DebugInfo = [];

% An = logical(A);
%% Matrix A prepocess

if(isfield(Params, 'SimilatiryMatrixPreprocess'))
    % clear diagonal
    if(isfield(Params.SimilatiryMatrixPreprocess, 'ClearDiagonal') && Params.SimilatiryMatrixPreprocess.ClearDiagonal)
        % From now on we can clear
        % diagonal, but follown ordinary steps of the algorithm
        %Params.AlgorithmParams.Diagonal = 0;
        for i = 1:objNum
            A(i,i) = 0;
        end
        %else
        %Params.AlgorithmParams.Diagonal = 1;
    end
    if(isfield(Params.SimilatiryMatrixPreprocess, 'Recalculate'))
        switch(Params.SimilatiryMatrixPreprocess.Recalculate)
            case 'neighbour'
                A = calcNeighbourhood(A);
            case 'pearson'
                A = calcPearson(A);
                
        end
    end
    if(isfield(Params.SimilatiryMatrixPreprocess, 'Subtract'))
        switch(Params.SimilatiryMatrixPreprocess.Subtract)
            case 'mean'
                if(isfield(Params.SimilatiryMatrixPreprocess, 'ClearDiagonal') && Params.SimilatiryMatrixPreprocess.ClearDiagonal)
                    val = sum(sum(A))./(objNum*(objNum - 1));
                else
                    val = mean(mean(A));
                end
            case 'value'
                if(~isfield(Params.SimilatiryMatrixPreprocess, 'SubtractValue'))
                    warning('MatrixPreprocess:nosubtractVal','No entered value for subtraction... setting to 0');
                    val = 0;
                else
                    val = Params.SimilatiryMatrixPreprocess.SubtractValue;
                end
            case 'random'
                val = sum(A,2)*sum(A,1)./(2*sum(sum(A)));
            otherwise
                warning('MatrixPreprocess:nosubtractVal','Not correct matrix preprocess parameter...');
                val = 0;
        end
        A = A - val;
    end
    
    if(isfield(Params.SimilatiryMatrixPreprocess, 'ClearDiagonal') && Params.SimilatiryMatrixPreprocess.ClearDiagonal)
        % clear diagonal again
        for i = 1:objNum
            A(i,i) = 0;
        end
    end
end

% A = A.*An;

%% Find clusters

if(~isfield(Params, 'IterationScheme'))
    Params.IterationScheme.IterationSchemeName = 'ARA_All';
    Params.IterationScheme.IterationSchemeFunc = @ARA_All;
end

switch(char(Params.IterationScheme.IterationSchemeFunc))
    case 'ARA_All'
        [clustIncidence, DebugInfo] = Params.IterationScheme.IterationSchemeFunc(A, Params.AlgorithmParams);
    case 'ARA_Fast'
        [clustIncidence, DebugInfo] = Params.IterationScheme.IterationSchemeFunc(A, Params.AlgorithmParams);
    case 'ARA_Dyn'
        [clustIncidence, DebugInfo] = Params.IterationScheme.IterationSchemeFunc(A, Params.AlgorithmParams);
end

if(isfield(Params, 'LabelFormat') && Params.LabelFormat)
    [clustIncidence, ~] = find(clustIncidence');
end

