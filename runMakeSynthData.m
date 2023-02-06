clearvars
close all
clc
Colors

% -----------------------
noe = 1e6;
Nx = 200; % Nx must be even

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
        MakeSynthExpsData;

        %% -----------------------
        expType = "singleScale";
        L = 5;
        MakeSynthExpsData;


        %% -----------------------
        expType = "mcD";
        L = 5;
        MakeSynthExpsData;


        %% -----------------------
        expType = "NonStat";
        L = 5;
        MakeSynthExpsData;

    end
end
