OptLocScale = zeros(length(NeAll),1);
for ii=1:length(NeAll)
    Ne = NeAll(ii);
    if localOb == 0
        if expType == "multiScale"
            filename = strcat('./TradLocTuning/',expType,'_tuning_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        elseif expType == "NonStat"
            filename = strcat('./TradLocTuning/',expType,'_tuning_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        else
            filename = strcat('./TradLocTuning/',expType,'_tuning_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        end
    else
        if expType == "multiScale"
            filename = strcat('./TradLocTuningNonLocObs/',expType,'_tuning_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        elseif expType == "NonStat"
            filename = strcat('./TradLocTuningNonLocObs/',expType,'_tuning_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        else
            filename = strcat('./TradLocTuningNonLocObs/',expType,'_tuning_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        end  
    end
    load(filename, 'rmse')
    avgrmse = mean(rmse,2);
    [a,b]=min(avgrmse);
    disp(['For ensemble size ', num2str(Ne),', optimal length scale: ',num2str(Lloc(b))])
    OptLocScale(ii) = Lloc(b);
    disp(avgrmse(b))    
end

if localOb == 0
    if expType == "multiScale"
        filename = strcat('./TradLocTuning/',expType,'_TradLoc_OptLocScale_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    elseif expType == "NonStat"
        filename = strcat('./TradLocTuning/',expType,'_TradLoc_OptLocScale_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    else
        filename = strcat('./TradLocTuning/',expType,'_TradLoc_OptLocScale_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    end
else
    if expType == "multiScale"
        filename = strcat('./TradLocTuningNonLocObs/',expType,'_TradLoc_OptLocScale_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    elseif expType == "NonStat"
        filename = strcat('./TradLocTuningNonLocObs/',expType,'_TradLoc_OptLocScale_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    else
        filename = strcat('./TradLocTuningNonLocObs/',expType,'_TradLoc_OptLocScale_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    end
end
save(filename,'OptLocScale')

