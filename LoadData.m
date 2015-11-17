function Data = LoadData(DatasetList)
% Function loads datasets according to DatasetList in to cell array of
% structures
%
% Input:
% Dataset - cell-array with the following format:
%   * Dataset Name (string)
%   * Dataset Loading File(string of function handle);
%   * Parameters (struct)
%
% Output:
% Data - cell-array with the following format of structs in each cell:
%   * .name - name of dataset (string)
%   * .X - [object x feature] matrix (double)
%   * .truth - cluster label vector (double)
%   * .clNum - number of clusters (double)

numData = size(DatasetList,1);

Data = cell(numData,1);

for d = 1:numData
    Data{d} = struct('name', [], 'X', [], 'truth', [], 'clNum', []);
    
    Data{d}.name = DatasetList{d,1};
    [Data{d}.X, Data{d}.truth] = feval(DatasetList{d,2},DatasetList{d,3});
    Data{d}.clNum = length(unique(Data{d}.truth));
end