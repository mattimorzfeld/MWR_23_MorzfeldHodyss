%% 
clear 
close all
clc
Colors

%% setup
NeAll = [10 20 40 60 80 100];

r = 1; ObsDist = 200;

ExpType = cell(4,1);
ExpType{1} = "singleScale";
ExpType{2} = "multiScale";
ExpType{3} = "mcD";
ExpType{4} = "NonStat";

for xx = 1:4
    expType = ExpType{xx};
    if expType == "multiScale"
        L = [2, 0.5, 20, 0.5];
    else
        L = 5;
    end
    
    ComputeKFRMSE;
    % ------------------------------------------
    
    %% Plot Prior loc
    avg_rmse = zeros(length(NeAll),1);
    for kk=1:length(NeAll)
        Ne = NeAll(kk);
        if expType == "multiScale"
            filename = strcat('./Results/',expType,'_Results_PriorLoc_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        elseif expType == "NonStat"
            filename = strcat('./Results/',expType,'_Results_PriorLoc_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        else
            filename = strcat('./Results/',expType,'_Results_PriorLoc_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        end
        load(filename,'rmse')
        avg_rmse(kk)=mean(rmse);
    end
    figure, hold on
    plot(NeAll,avg_rmse/rmseKF,'.-','Color',Color(7,:),'MarkerSize',35,'LineWidth',3)
    set(gcf,'Color','w')
    set(gca,'FontSize',20)
    xlabel('Ensemble size')
    ylabel('Normalized RMSE')
    box off
    
    %% Plot Post loc seq
    avg_rmse = zeros(length(NeAll),1);
    for kk=1:length(NeAll)
        Ne = NeAll(kk);
        if expType == "multiScale"
            filename = strcat('./Results/',expType,'_Results_PostLocSeq_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        elseif expType == "NonStat"
            filename = strcat('./Results/',expType,'_Results_PostLocSeq_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        else
            filename = strcat('./Results/',expType,'_Results_PostLocSeq_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        end
        load(filename,'rmse')
        avg_rmse(kk)=mean(rmse);
    end
    plot(NeAll,avg_rmse/rmseKF,'.-','Color',Color(8,:),'MarkerSize',35,'LineWidth',3)
    set(gcf,'Color','w')
    set(gca,'FontSize',20)
    xlabel('Ensemble size')
    ylabel('Normalized RMSE')
    box off
    
    
    %% Plot Flowerdew's loc seq
    avg_rmse = zeros(length(NeAll),1);
    for kk=1:length(NeAll)
        Ne = NeAll(kk);
        if expType == "multiScale"
            filename = strcat('./Results/',expType,'_Results_FDLocSeq_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        elseif expType == "NonStat"
            filename = strcat('./Results/',expType,'_Results_FDLocSeq_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        else
            filename = strcat('./Results/',expType,'_Results_FDLocSeq_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        end
        load(filename,'rmse')
        avg_rmse(kk)=mean(rmse);
    end
    
    plot(NeAll,avg_rmse/rmseKF,'.--','Color',Color(9,:),'MarkerSize',35,'LineWidth',3)
    set(gcf,'Color','w')
    set(gca,'FontSize',20)
    xlabel('Ensemble size')
    ylabel('Normalized RMSE')
    box off
    
    %% Plot trad loc
    avg_rmse = zeros(length(NeAll),1);
    for kk=1:length(NeAll)
        Ne = NeAll(kk);
        if expType == "multiScale"
            filename = strcat('./Results/',expType,'_Results_TradLoc_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        elseif  expType == "NonStat"
            filename = strcat('./Results/',expType,'_Results_TradLoc_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        else
            filename = strcat('./Results/',expType,'_Results_TradLoc_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        end
        load(filename,'rmse')
        avg_rmse(kk)=mean(rmse);
    end
    
    plot(NeAll,avg_rmse/rmseKF,'.-','Color',Color(11,:),'MarkerSize',35,'LineWidth',3)
    set(gcf,'Color','w')
    set(gca,'FontSize',20)
    xlabel('Ensemble size')
    ylabel('RMSE')
    box off
    
    %% No loc
    avg_rmse = zeros(length(NeAll),1);
    for kk=1:length(NeAll)
        Ne = NeAll(kk);
        if expType == "multiScale"
            filename = strcat('./Results/',expType,'_Results_NoLoc_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        elseif  expType == "NonStat"
            filename = strcat('./Results/',expType,'_Results_NoLoc_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        else
            filename = strcat('./Results/',expType,'_Results_NoLoc_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        end
        load(filename,'rmse')
        avg_rmse(kk)=mean(rmse);
    end
    
    plot(NeAll,avg_rmse/rmseKF,'.-k','MarkerSize',35,'LineWidth',3)
    set(gcf,'Color','w')
    set(gca,'FontSize',20)
    xlabel('Ensemble size')
    ylabel('RMSE')
    box off
     
    
    legend('Prior-opt.', 'Post.-opt.', 'Flowerdew, 2015','Gaussian','No loc.')
    
    xlim([5 NeAll(end)+5]);
    ylim([1 1.03]) 
end

