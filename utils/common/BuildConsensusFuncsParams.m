function FuncList = BuildConsensusFuncsParams(X,RealLabels,A,P,Ensemble,Task4Experiment)
% Функция добавляет в соответстующую структуру необходимые параметры для
% постоения консенсуса в зависимости от агрегирующей функции

[n,l] = size(Ensemble);

FuncList = Task4Experiment.ConsensusFuncs;

% Применяем венгерский алгоритм для переобозначения
% Для расчета A и Р делать совсем не обязательно!
if any(strncmpi(FuncList(:,2),'borda',5) | strncmpi(FuncList(:,2),'cond',4))
    Ref = Ensemble(:,1); % выбираем ссылку
    RelabelEnsemble = BuildRelabeling(Ensemble,Ref);
end

for iFunc = 1:size(FuncList,1)
   eval(sprintf('FuncList{%d,3} = %s;',iFunc,FuncList{iFunc,3})); 
end

end