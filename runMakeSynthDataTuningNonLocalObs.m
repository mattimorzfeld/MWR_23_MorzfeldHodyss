clearvars
close all
clc
Colors

% -----------------------
noe = 1e4;
Nx = 200; % Nx must be even

rAll = 1;
ObsDistAll = [2 200];

localOb = 1;
for cc=1:length(rAll)
    r = rAll(cc);
    for bb=1:length(ObsDistAll)
        ObsDist = ObsDistAll(bb);
        
        %% -----------------------
        expType = "multiScale";
        L = [2, 0.5, 20, 0.5];
        MakeSynthExpsDataTuning;

        %% -----------------------
        expType = "singleScale";
        L = 5;
        MakeSynthExpsDataTuning;

        %% -----------------------
        expType = "mcD";
        L = 5;
        MakeSynthExpsDataTuning;

        %% -----------------------
        expType = "NonStat";
        L = 5;
        MakeSynthExpsDataTuning;

    end
end
