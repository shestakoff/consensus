function [labels, contrib, intensity, ff] = RunAddionsScheme(A, Params)
% Scheme for original Mirkins algorithm
% P is assumed have no diagonal (zeros stand there): criterion max f(S)
% with z_i=1 for i in S and z_i=-1 otherwise
% f(S)= sum_i_in_S a(i,S)/|S|
% where a(i,S)=sum_j_in_S(a_{ij}) -(z_i+1)a_{ii}/2
% Delta(i)=-2z_i(a(i,S)-f(S)/2)/(|S|-z_i) is increase in f(S) with z_i to be reversed
%
% fins - cluster, fc its absolute contribution, inten, intensity
%
% Input:
% A - symmetric similarity matrix A
% Params - structure with parameters
%
% Output:
% labels - vector of cluster labels
% contrib - cluster contributions
% intensity - cluster intensity
% ff - smth

%% Initializations
A = (A + A')./2;
objNum = size(A,1);

%% Matrix preprosses

if(isfield(Params, 'SimilatiryMatrixPreprocess'))
    if(isfield(Params.SimilatiryMatrixPreprocess, 'Subtract'))
        switch(Params.SimilatiryMatrixPreprocess.Subtract)
            case 'mean'
                aver = sum(sum(A))./(objNum*(objNum - 1));
            case 'value'
                if(~isfield(Params.SimilatiryMatrixPreprocess, 'SubtractVal'))
                    warning('MatrixPreprocess:nosubtractVal','No entered value for subtraction... setting to 0');
                    aver = 0;
                else
                    aver = Params.SimilatiryMatrixPreprocess.SubtractVal;
                end
            case 'random'
                aver = sum(A,1)*sum(A,2)./sum(sum(A));
            otherwise
                warning('MatrixPreprocess:nosubtractVal','Not correct matrix preprocess parameter...');
                aver = 0;
        end
    end
else
    aver = 0;
end
%% Run!

[labels, contrib, intensity,ff] = addisnav(A,aver);

