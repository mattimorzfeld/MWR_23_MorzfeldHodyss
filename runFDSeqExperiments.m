clearvars
close all
clc
Colors

% -----------------------
noe = 1e4;
Nx = 200; % Nx must be even
NeAll = [10 20 40 60 80 100];
% -----------------------
normLoc = false; % set to true (false) to (not) normalize priorLoc and postLoc to one
noMeanSampling = 0; % set to 1 (0) to (not) have sampling error in the prior mean 

rAll = 10;
ObsDistAll = 200;
localOb = 0;

for cc=1:length(rAll)
    r = rAll(cc);
    for bb=1:length(ObsDistAll)
        ObsDist = ObsDistAll(bb);
        
        %% -----------------------
        expType = "multiScale";
        L = [2, 0.5, 20, 0.5];
        RunExpsFDLoc_Seq;
        
        %% -----------------------
        expType = "singleScale";
        L = 5;
        RunExpsFDLoc_Seq;
        
        %% -----------------------
        expType = "mcD";
        L = 5;
        RunExpsFDLoc_Seq;

        %% -----------------------
        expType = "NonStat";
        L = 5;
        RunExpsFDLoc_Seq;
    end
end
