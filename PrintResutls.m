%% Print Latex Tables

InDir = './results';
OutDir = './results/LatexTables';
mkdir(OutDir);

fileDir = dir('./results');

fileNames = {fileDir(:).name};
idx = [fileDir(:).isdir];
fileNames = fileNames(~idx);

idx = strfind(fileNames, '.mat');
idx = cellfun(@(x) isempty(x), idx);
fileNames = fileNames(~idx);

for ifile = 1:length(fileNames)
   print_results_latex(fileNames{ifile}, InDir, OutDir, 0, 0); 
   print_results_latex(fileNames{ifile}, InDir, OutDir, 0, 1);
   print_results_latex(fileNames{ifile}, InDir, OutDir, 1, 0); 
   print_results_latex(fileNames{ifile}, InDir, OutDir, 1, 1);
end

