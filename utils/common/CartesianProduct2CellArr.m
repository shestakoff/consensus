function [CProd] = CartesianProduct2CellArr(FactorsCellArr, Horizontal, MakeCells)
% Make Cartesian product of different factors and save it to cell-array
%
% Input
% FactorsCellArr {cellarray of cellarrays} - FactorsCellArr{i} is cellarray
%                                            of possible values of Factor i
% Horizontal[bool] - checks if concatenation will be vertical of
% horizontal; with horizontal concatenation row-vectors as param values are
% allowed, with vertical- column-vectors. By default, Horizontal = false
% MakeCells[bool] - checks if the result if cellarray of vectors (false) or
% cellarray of cellarrays (true). Make it true if factors are not all
% numbers (there are strings, handles etc)
% Output
% CProd {cellarray of vectors} - each element of CProd is one point of
%                                Cartesian product
%
% Example
% CProd = CartesianProduct2CellArr({{1,2}, {3,4}})
% Result: CProd = {[1;3], [2;3], [1;4], [2;4]}
%
%CProd = CartesianProduct2CellArr({{1,2}, {3,4}},1)
%Result: CProd = {[1 3], [2 3], [1 4], [2 4]}

if nargin < 2 || isempty(Horizontal), Horizontal = 0; end
if nargin < 3 || isempty(MakeCells), MakeCells = 0; end

NFactors = length(FactorsCellArr);
FactorsLen = zeros(1, NFactors); %length of factors
% Strings for generating RUN-ndgrid-string and get result
OutIdsStrArr = cell(1, NFactors);
InpStrArr = cell(1, NFactors);
ResultStrArr = cell(1, NFactors);
N_CProd = 1; %Number of elements in Cartesian product

% Calculate number of elements in Cartesian product
% and make Strings for generating RUN-ndgrid-string and get result
for i = 1 : NFactors    
    FactorsLen(i) = length(FactorsCellArr{i});
    N_CProd = N_CProd * FactorsLen(i);
    OutIdsStrArr{i} = sprintf('OutIds{%d}', i);
    InpStrArr{i} = sprintf('[1:%d]', FactorsLen(i));
    ResultStrArr{i} = sprintf('FactorsCellArr{%d}{OutIds{%d}(i)}', i, i);
end;

if Horizontal, str_sep = ',';
else str_sep = ';'; end
if MakeCells, Brackets = '{}';
else Brackets = '[]'; end
ResultStr = [Brackets(1), strarray2str(ResultStrArr, str_sep), Brackets(2)]; %Get result - string

% Run ndgrid-function (make Cartesian product)
eval(['[', strarray2str(OutIdsStrArr, ','), '] = ndgrid(',...
     strarray2str(InpStrArr, ','), ');']);

% Make CProd
% !Attention: FOR-block must be 'i'-indexed (look ResultStr)
CProd = cell(1, N_CProd);
for i = 1 : N_CProd
    CProd{i} = eval(ResultStr);
end;

