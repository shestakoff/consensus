function ParamsVariants = ParamsCartesian(Params,MakeCells)
% Makes a cartesian product of "params" variants, where params are
% represented as a structure
%
%Input
% Params[struct] - the structure of the same format as one "params" unit,
% with actual values replaced by cell arrays of variants for this value, e.g.
% Params.ForecastRateParams.WeightParam = {0.15, 0.05, 0.005}; % весовой коэффициент
% Params.ForecastRateParams.KPTPeriodParams = [0 90 180]; % период (в днях), за который берутся выпуски при построении КПТ по линейке
% Params.ForecastRateParams.SmoothParam = 11; % параметр медианного сглаживания
% Params.SeasonalityParams.UseSeasonality = {0,1,2}; % параметр, отвечающий за выбор сезонности
% Params.SeasonalityParams.TrendParam = 0.999; % параметр сглаживания тренда
% Params.SeasonalityParams.TheilWageParam = {[0.1,0.9,0.9,1],[0.1,0.9,1,1]}; % параметры алгоритма Тейла-Вейджа
% Params.FindIssuesParams.IssNumParam = 10; % минимальное количество похожих выпусков
% Params.FindIssuesParams.IssDateParam = 30; % параметр, отвечающий за то, в каком диапазоне дат осуществляется поиск похожих выпусков
% Params.FindIssuesParams.IssDateStepParam = 30; % параметр, отвечающий за то, как расширяется диапазон дат при поиске похожих выпусков
% Params.FindIssuesParams.IssTimeParam = 60; % параметр, отвечающий за то, насколько может отличаться время выхода выпусков при поиске похожих выпусков
% Params.FindIssuesParams.WeekDayParam = {[0 0 0 0 0 1 1],[0 0 0 0 1 2 3]};
%
% MakeCells[bool] - make it true if params are not all numbers (like strings, handles etc)
%Output
% ParamsVariants[Nx1 struct] - all combinations of the variants given,
% each struct in the array is an actual structure of the parameters
%
%See also
% ParamStruct2Vec, ParamVec2Struct

[CartesianCell ParamsLegend] = ParamStruct2Vec(Params,1);
if ~exist('MakeCells','var')
    MakeCells = 1;
end
CartProd = CartesianProduct2CellArr(CartesianCell,1,MakeCells);
numProd = length(CartProd);
ParamsVariants = ParamVec2Struct(CartProd{1},ParamsLegend);
for k=2:numProd
    ParamsVariants(end+1) = ParamVec2Struct(CartProd{k},ParamsLegend);
end

end