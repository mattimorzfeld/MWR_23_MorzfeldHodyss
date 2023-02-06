if localOb == 0
    if expType == "multiScale"
        filename = strcat('./SynthData/',expType,'_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
        load(filename,'Xt','Y','H','u','l','r','L')
    elseif expType == "NonStat"
        filename = strcat('./SynthData/',expType,'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
        load(filename,'Xt','Y','H','u','l','r','L')
    else
        filename = strcat('./SynthData/',expType,'_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
        load(filename,'Xt','Y','H','u','l','r','L')
    end
else
    if expType == "multiScale"
        filename = strcat('./NonLocObsSynthData/',expType,'_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
        load(filename,'Xt','Y','H','u','l','r','L')
    elseif expType == "NonStat"
        filename = strcat('./NonLocObsSynthData/',expType,'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
        load(filename,'Xt','Y','H','u','l','r','L')
    else
        filename = strcat('./NonLocObsSynthData/',expType,'_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
        load(filename,'Xt','Y','H','u','l','r','L')
    end
end


for kk=1:length(NeAll)
    Ne=NeAll(kk);
    fprintf('Ne = %g\n',Ne)
    rmse = ExpsPostLoc_seq(noe,Ne,u,l,r,H,L,Xt,Y,expType,noMeanSampling);
    if localOb == 0
        if expType == "multiScale"
            filename = strcat('./Results/',expType,'_Results_PostLocSeq_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        elseif expType == "NonStat"
            filename = strcat('./Results/',expType,'_Results_PostLocSeq_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        else
            filename = strcat('./Results/',expType,'_Results_PostLocSeq_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        end
    else
        if expType == "multiScale"
            filename = strcat('./NonLocObsResults/',expType,'_Results_PostLocSeq_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        elseif expType == "NonStat"
            filename = strcat('./NonLocObsResults/',expType,'_Results_PostLocSeq_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        else
            filename = strcat('./NonLocObsResults/',expType,'_Results_PostLocSeq_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        end
    end
    save(filename,'rmse')
end
