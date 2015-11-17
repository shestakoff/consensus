function DrawExperimentResults(Results, DataArr, ConsFuncList, DrawParams)

ConsNames = ConsFuncList(:,1);
numData = length(DataArr);
numCons = length(ConsNames);
mkdir(DrawParams.Dir);

%% Collecting all in a single matrices
for idata = 1:numData
    
    DatasetName = DataArr{idata}.name;
    numExper = DataArr{idata}.ExperimentScheme.ExperimentsNum;
    grIdx = NaN(numCons*numExper,1);
    numObjects = size(DataArr{idata}.truth,1);
    ArrARI = NaN(numExper, numCons);
    ArrNMI = NaN(numExper, numCons);
    ArrACC = NaN(numExper, numCons);
    Labels = NaN(numObjects, numCons+1);
    for icons = 1:numCons
        ArrARI(:,icons) = Results{idata, icons}.ari;
        ArrACC(:,icons) = Results{idata, icons}.acc;
        ArrNMI(:,icons) = Results{idata, icons}.nmi;
        ArrClass(:,icons) = Results{idata, icons}.cclNum;
        grIdx((icons-1)*numExper+1:icons*numExper) = icons;
    end
    
    for iExp = 1:numExper
        for icons = 1:numCons
            Labels(:,icons) = Results{idata, icons}.sol(:, iExp);
        end
        Labels(:,end) = DataArr{idata}.truth;
        h = maximizeFigure();
        imagesc(Labels);
        xticklabel_rotate(1:numCons,45,ConsNames)
%         tightfig;
        title([DataArr{idata}.name ': exper. ' num2str(iExp)], 'FontSize', 14, 'FontName', 'Times', 'Interpreter','tex');
        saveas(h,[DrawParams.Dir DatasetName '_ConsPartitions_Experiment-' num2str(iExp) '.png']);
        close
        
        [A,~,~] = BuildEnsembleFormats(DataArr{idata}.Ensemble{iExp});
        h = maximizeFigure();
        imagesc(A);
        tightfig;
        title([DataArr{idata}.name ' consensus matrix '  ': exper. ' num2str(iExp)], 'FontSize', 14, 'FontName', 'Times', 'Interpreter','tex');
        saveas(h,[DrawParams.Dir DatasetName '_ConsMatrix_Experiment-' num2str(iExp) '.png']);
        close
        
        h = maximizeFigure();
        imagesc(DataArr{idata}.Ensemble{iExp});
        tightfig;
        title([DataArr{idata}.name ' ensemble '  ': exper. ' num2str(iExp)], 'FontSize', 14, 'FontName', 'Times', 'Interpreter','tex');
        saveas(h,[DrawParams.Dir DatasetName '_Ensemble_Experiment-' num2str(iExp) '.png']);
        close
    end
    
    % Plot ARI
    h = maximizeFigure();
    boxplot(ArrARI(:),grIdx);
    set(gca,'XTick',1:numCons)
    set(gca,'XTickLabel',ConsNames)
    xticklabel_rotate([],45,[])
    xlabel('Partitions', 'FontSize', 14, 'FontName', 'Times', 'Interpreter','tex');
    ylabel('$\phi^{ARI}$', 'FontSize', 14, 'FontName', 'Times', 'Interpreter','latex');
    saveas(h,[DrawParams.Dir DatasetName '_ARI.png']);
    close
    
    % Plot ACC
    h = maximizeFigure();
    boxplot(ArrACC(:),grIdx);
    set(gca,'XTick',1:numCons)
    set(gca,'XTickLabel',ConsNames)
    xticklabel_rotate([],45,[])
    xlabel('Partitions', 'FontSize', 14, 'FontName', 'Times', 'Interpreter','tex');
    ylabel('$\phi^{ACC}$', 'FontSize', 14, 'FontName', 'Times', 'Interpreter','latex');
    saveas(h,[DrawParams.Dir DatasetName '_ACC.png']);
    close
    
    % Plot NMI
    h = maximizeFigure();
    boxplot(ArrNMI(:),grIdx);
    set(gca,'XTick',1:numCons)
    set(gca,'XTickLabel',ConsNames)
    xticklabel_rotate([],45,[])
    xlabel('Partitions', 'FontSize', 14, 'FontName', 'Times', 'Interpreter','tex');
    ylabel('$\phi^{NMI}$', 'FontSize', 14, 'FontName', 'Times', 'Interpreter','latex');
    saveas(h,[DrawParams.Dir DatasetName '_NMI.png']);
    close
    
    % Plot Classes
    h = maximizeFigure();
    boxplot(ArrClass(:),grIdx);
    set(gca,'XTick',1:numCons)
    set(gca,'XTickLabel',ConsNames)
    xticklabel_rotate([],45,[])
    xlabel('Partitions', 'FontSize', 14, 'FontName', 'Times', 'Interpreter','tex');
    ylabel('Cluster number', 'FontSize', 14, 'FontName', 'Times', 'Interpreter','tex');
    saveas(h,[DrawParams.Dir DatasetName '_Clust_num.png']);
    close
    
end

end


