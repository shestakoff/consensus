function CS = CondScore(cl1,cl2)
ConTable=crosstab(cl1,cl2); % Таблица сопрященности
na=sum(ConTable,2); % Сумма элементов по строкам. Соответствует первому аргументу в crosstab
nb=sum(ConTable,1); % Сумма элементов по столбцам. Соответствует второму аргументу в crosstab

[numa, numb]=size(ConTable);
n=size(cl1,1);


CS=0;
for i=1:numa
    for j=1:numb
        CS=CS+ConTable(i,j)./nb(j).*ConTable(i,j)./n;
    end
end

end