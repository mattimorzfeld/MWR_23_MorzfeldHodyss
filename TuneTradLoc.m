if localOb == 0
    if expType == "multiScale"
        filename = strcat('./SynthData/Tuning/',expType,'_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    elseif expType == "NonStat"
        filename = strcat('./SynthData/Tuning/',expType,'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    else
        filename = strcat('./SynthData/Tuning/',expType,'_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    end
else
    if expType == "multiScale"
        filename = strcat('./NonLocObsSynthData/Tuning/',expType,'_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    elseif expType == "NonStat"
        filename = strcat('./NonLocObsSynthData/Tuning/',expType,'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    else
        filename = strcat('./NonLocObsSynthData/Tuning/',expType,'_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    end
end
    
load(filename,'Xt','Y','H','u','l','r','L')

%% pre-allocate
rmse = zeros(length(L),noe);

for ii=1:length(NeAll)
    Ne = NeAll(ii);
    fprintf('Ensemble size: %g\n', Ne)
    for kk=1:length(Lloc)
        fprintf('Length scale %g\n',Lloc(kk))
        rmse(kk,:) = ExpsTradLoc(noe,Ne,Lloc(kk),u,l,L,r,H,Xt,Y,expType,noMeanSampling);
    end
    avg_rmse = mean(rmse,2);
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
    save(filename, 'rmse')
end

