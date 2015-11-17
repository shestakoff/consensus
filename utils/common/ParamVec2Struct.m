function ParamStruct = ParamVec2Struct(ParamVec,ParamVecLegend)
% Converts the parameters vector into structure. Is the opposite to
% ParamStruct2Vec.
%
%Input
% ParamVec[Nx1| Nx1 cell]  the structure ParamStruct, serialized into a vector
% ParamVecLegend{Nx1} - the legend for the fields of the serialized
% structure
%
%Output
% Params[struct] -  the structure of parameters. Structure might contain
% numbers, vectors of other structures
% Params.ForecastRateParams.WeightParam = 0.05; % весовой коэффициент
% Params.ForecastRateParams.KPTPeriodParams = KPTPeriodParams; % период (в дн€х), за который берутс€ выпуски при построении  ѕ“ по линейке
% Params.ForecastRateParams.SmoothParam = 11; % параметр медианного сглаживани€
% 
% Params.SeasonalityParams.UseSeasonality = 1; % параметр, отвечающий за выбор сезонности
% % 0 - не использовать сезонность (в качестве сезонности используетс€ нулевой р€д);
% % 1 - использовать глобальную промасштабированную сезонность;
% % 2 - сезонность по линейке
% Params.SeasonalityParams.TrendParam = 0.999; % параметр сглаживани€ тренда
% Params.SeasonalityParams.TheilWageParam = [0.1,0.9,0.9,1]; % параметры алгоритма “ейла-¬ейджа
% 
% Params.FindIssuesParams.IssNumParam = 10; % минимальное количество похожих выпусков
% Params.FindIssuesParams.IssDateParam = 30; % параметр, отвечающий за то, в каком диапазоне дат осуществл€етс€ поиск похожих выпусков
% Params.FindIssuesParams.IssDateStepParam = 30; % параметр, отвечающий за то, как расшир€етс€ диапазон дат при поиске похожих выпусков
% Params.FindIssuesParams.IssTimeParam = 60; % параметр, отвечающий за то, насколько может отличатьс€ врем€ выхода выпусков при поиске похожих выпусков
% Params.FindIssuesParams.WeekDayParam = [0 0 0 0 1 2 3];
%
%See also
% ParamStruct2Vec

ParamStruct = [];
if nargin < 2 || isempty(ParamVec) || isempty(ParamVecLegend), return; end
VecLen = length(ParamVec);
if VecLen ~=length(ParamVecLegend), 
    error('ParamVec2Struct:IncorrectInput','The lengths of the vector and its legend are different!');
end


Params = unique(ParamVecLegend);
MakeCells = iscell(ParamVec);
for p=1:length(Params)
    param = Params{p};
    idx = strmatch(param,ParamVecLegend,'exact');
    % [Daniel, 16.07.2011] Ѕудем хранить все значени€ параметров в cell-ах
    if MakeCells
        eval(['ParamStruct.' param '= ParamVec{idx};']);
    else
        eval(['ParamStruct.' param '= ParamVec(idx);']);
    end


end
    


end