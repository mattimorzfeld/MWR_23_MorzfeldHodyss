%% 
clear 
close all
clc
Colors

%% setup
Ne = 40;
ObsDist = 200;
r = 5; 

ExpTypeAll = cell(4,1);
ExpTypeAll{1} = "singleScale";
ExpTypeAll{2} = "multiScale";
ExpTypeAll{3} = "mcD";
ExpTypeAll{4} = "NonStat";

TitleName = cell(4,1);
TitleName{1} = "Single-scale";
TitleName{2} = "Multi-scale";
TitleName{3} = "Pressure-wind";
TitleName{4} = "Nonstationary";


Nx = 200;
for kk = 1:4
    expType = ExpTypeAll{kk};
    if expType == "multiScale"
        L = [2, 0.5, 20, 0.5];
    else
        L = 5;
    end

    
    C = getCov(Nx, L, expType);
    figure(2)
    subplot(2,2,kk)
    imagesc(C)
    colormap(viridis(100))
    caxis([-1 1])
    set(gcf,'Color','w')
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    set(gca,'FontSize',16)
    title(TitleName{kk})   
end

figure(2)
h = axes(gcf,'visible','off'); 
title(h,'title');
c = colorbar(h,'Position',[0.93 0.168 0.022 0.7]);
caxis([-1 1])
set(gcf,'Color','w')




