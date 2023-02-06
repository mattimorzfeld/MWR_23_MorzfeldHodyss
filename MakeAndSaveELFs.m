%%
clearvars
close all
clc

%% Make and save ELFs
noe = 1e6;
R = 1;
ObsDist = 20;
NeAll = [5 10 20 60 80 100];
for oo=1:length(NeAll)
    Ne = NeAll(oo);
    
    ExpTypeAll = cell(4,1);
    ExpTypeAll{1} = "singleScale";
    ExpTypeAll{2} = "multiScale";
    ExpTypeAll{3} = "mcD";
    ExpTypeAll{4} = "NonStat";
    
    for zz=1:length(ExpTypeAll)
        expType = ExpTypeAll{zz};
        if expType == "multiScale"
            L = [2, 0.5, 20, 0.5];
        else
            L = 5;
        end
        
        if expType == "multiScale"
            filename = strcat(expType,'_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(R),'.mat');
            load(filename,'Xt','Y','H','u','l','r','L')
        elseif expType == "NonStat"
            filename = strcat(expType,'_ObsDist_',num2str(ObsDist),'_R_',num2str(R),'.mat');
            load(filename,'Xt','Y','H','u','l','r','L')
        else
            filename = strcat(expType,'_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(R),'.mat');
            load(filename,'Xt','Y','H','u','l','r','L')
        end
        
        nx = length(Xt(:,1));
        if expType == "mcD"
            nx = nx/2;
        end
        B = getCov(nx,L,expType);
        ElF_alpha = elfLoc(Ne,noe,H,r,B);
        
        
        if expType == "multiScale"
            filename = strcat('./',expType,'_ELFLoc_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        elseif expType == "NonStat"
            filename = strcat('./',expType,'_ELFLoc_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        else
            filename = strcat('./',expType,'_ELFLoc_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        end
        save(filename,'ElF_alpha')
    end
end
