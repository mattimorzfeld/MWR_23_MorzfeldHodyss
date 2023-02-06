%% 
clear 
close all
clc
Colors

%% setup
Ne = 40;
ObsDist = 2;

sy = 1;
r = 1;
b = 1/(sy^2+r);

ExpTypeAll = cell(4,1);
ExpTypeAll{1} = "singleScale";
ExpTypeAll{2} = "multiScale";
ExpTypeAll{3} = "mcD";
ExpTypeAll{4} = "NonStat";

TitleName = cell(4,1);
TitleName{1} = "Single-scale";
TitleName{2} = "Multiscale";
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
    
    P = getCov(Nx, L, expType); 
    
    if expType == "NonStat"
        rxy = P(:,20);
        figure, hold on
        set(gcf,'Color','w')
        set(gca,'FontSize',16)
        xlabel('Grid point')
        box off
        
        %% prior loc
        aopt = (rxy.^2*(Ne-1))./(1+Ne*rxy.^2);
        hold on, plot(aopt','-','Color',Color(7,:),'LineWidth',3)
        
        %% posterior loc
        num = rxy.^2*( 1+2*sy^2*b* (sy^2*b-1)/(Ne-1) );
        den = rxy.^2 + 1/(Ne-1) * ( 1+rxy.^2*(1+2*b*sy^2*(3*b*sy^2-4)) );
        aopt = num./den;
        hold on, plot(aopt','-','Color',Color(8,:),'LineWidth',3)

        %% Flowerdew
        s = 0.5*log((1+rxy)./(1-rxy));
        ss = 1/sqrt(Ne-3);
        tmp1 = tanh(s+ss);
        tmp2 = tanh(s-ss);
        rcGs = 0.5*abs(tmp1-tmp2);
        aopt = (rxy.^2)./(rxy.^2+rcGs.^2);
        hold on, plot(aopt','-','Color',Color(9,:),'LineWidth',3)
        
        %% ELF
        filename = strcat('./ELFs/',expType,'_ELFLoc_ObsDist_',num2str(20),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        load(filename)
        hold on, plot(ElF_alpha(:,2)','-','Color',Color(6,:),'LineWidth',3)
        
        %% Gaussian
        filename = strcat('./TradLocTuning/NonStat_TradLoc_OptLocScale_ObsDist_',num2str(2),'_R_',num2str(r),'.mat');
        load(filename)
        Lopt = OptLocScale(4); % for Ne = 40;
        PGaussLoc = getCov(Nx, Lopt, "singleScale");
        hold on, plot(PGaussLoc(:,20)','-','Color',Color(11,:),'LineWidth',3)
        
        %% correlation
        plot(rxy,'k')
        
        rxy = P(:,120);
        set(gcf,'Color','w')
        set(gca,'FontSize',16)
        xlabel('Grid point')
        box off
        title(TitleName{kk})
        ylim([0 1])
        
        %% prior loc
        aopt = (rxy.^2*(Ne-1))./(1+Ne*rxy.^2);
        hold on, plot(aopt',':','Color',Color(7,:),'LineWidth',3)
        
        %% posterior loc
        num = rxy.^2*( 1+2*sy^2*b* (sy^2*b-1)/(Ne-1) );
        den = rxy.^2 + 1/(Ne-1) * ( 1+rxy.^2*(1+2*b*sy^2*(3*b*sy^2-4)) );
        aopt = num./den;
        hold on, plot(aopt',':','Color',Color(8,:),'LineWidth',3)
        
        %% Flowerdew
        s = 0.5*log((1+rxy)./(1-rxy));
        ss = 1/sqrt(Ne-3);
        tmp1 = tanh(s+ss);
        tmp2 = tanh(s-ss);
        rcGs = 0.5*abs(tmp1-tmp2);
        aopt = (rxy.^2)./(rxy.^2+rcGs.^2);
        hold on, plot(aopt',':','Color',Color(9,:),'LineWidth',3)
        
        % ELF
        hold on, plot(ElF_alpha(:,7)',':','Color',Color(6,:),'LineWidth',3)
        
        %% Gaussian
        filename = strcat('./TradLocTuning/NonStat_TradLoc_OptLocScale_ObsDist_',num2str(2),'_R_',num2str(r),'.mat');
        load(filename)
        Lopt = OptLocScale(4); % for Ne = 40;
        PGaussLoc = getCov(Nx, Lopt, "singleScale");
        hold on, plot(PGaussLoc(:,120)',':','Color',Color(11,:),'LineWidth',3)
            
        %% correlation
        plot(rxy,'k:')
        
        ylim([0 1])
        
        legend('Prior-opt.','Post-opt.','Flowerdew, 2015', 'ELF','Gaussian','Correlation')
    elseif expType == "mcD"
        rxy = P(1:Nx,100);
        figure
        subplot(211)
        set(gcf,'Color','w')
        set(gca,'FontSize',16)
        xlabel('Grid point')
        box off
        title(TitleName{kk})
        
        %% prior loc
        aopt = (rxy.^2*(Ne-1))./(1+Ne*rxy.^2);
        hold on, plot(aopt','-','Color',Color(7,:),'LineWidth',3)
        
        %% posterior loc
        num = rxy.^2*( 1+2*sy^2*b* (sy^2*b-1)/(Ne-1) );
        den = rxy.^2 + 1/(Ne-1) * ( 1+rxy.^2*(1+2*b*sy^2*(3*b*sy^2-4)) );
        aopt = num./den;
        hold on, plot(aopt','-','Color',Color(8,:),'LineWidth',3)
        
        %% Flowerdew
        s = 0.5*log((1+rxy)./(1-rxy));
        ss = 1/sqrt(Ne-3);
        tmp1 = tanh(s+ss);
        tmp2 = tanh(s-ss);
        rcGs = 0.5*abs(tmp1-tmp2);
        aopt = (rxy.^2)./(rxy.^2+rcGs.^2);
        hold on, plot(aopt','-','Color',Color(9,:),'LineWidth',3)
        
        %% ELF
        filename = strcat('./ELFs/',expType,'_ELFLoc_L_',num2str(L),'_ObsDist_',num2str(20),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        load(filename)
        hold on, plot(ElF_alpha(1:Nx,6)','-','Color',Color(6,:),'LineWidth',3)
        
        %% Gaussian
        filename = strcat('./TradLocTuning/mcD_TradLoc_OptLocScale_L_5_ObsDist_',num2str(2),'_R_',num2str(r),'.mat');
        load(filename)
        Lopt = OptLocScale(4); % for Ne = 40;
        PGaussLoc = getCov(2*Nx, Lopt, "singleScale");
        hold on, plot(PGaussLoc(1:Nx,100)','-','Color',Color(11,:),'LineWidth',3)
        
        %% correlation
        plot(rxy,'k')
        
        ylabel('Pressure')
        legend('Prior-opt.','Post-opt.','Flowerdew, 2015', 'ELF','Gaussian','Correlation')
        ylim([0 1])
        
        rxy = P(Nx+1:end,100);
        subplot(212)
        set(gcf,'Color','w')
        set(gca,'FontSize',16)
        xlabel('Grid point')
        box off
        
        %% prior loc
        aopt = (rxy.^2*(Ne-1))./(1+Ne*rxy.^2);
        hold on, plot(aopt','-','Color',Color(7,:),'LineWidth',3)
        
        %% posterior loc
        num = rxy.^2*( 1+2*sy^2*b* (sy^2*b-1)/(Ne-1) );
        den = rxy.^2 + 1/(Ne-1) * ( 1+rxy.^2*(1+2*b*sy^2*(3*b*sy^2-4)) );
        aopt = num./den;
        hold on, plot(aopt','-','Color',Color(8,:),'LineWidth',3)
        
        %% Flowerdew
        s = 0.5*log((1+rxy)./(1-rxy));
        ss = 1/sqrt(Ne-3);
        tmp1 = tanh(s+ss);
        tmp2 = tanh(s-ss);
        rcGs = 0.5*abs(tmp1-tmp2);
        aopt = (rxy.^2)./(rxy.^2+rcGs.^2);
        hold on, plot(aopt','-','Color',Color(9,:),'LineWidth',3)
        
        %% ELF
        hold on, plot(ElF_alpha(Nx+2:end,6)','-','Color',Color(6,:),'LineWidth',3)
        
        %% Gaussian
        filename = strcat('./TradLocTuning/mcD_TradLoc_OptLocScale_L_5_ObsDist_',num2str(2),'_R_',num2str(r),'.mat');
        load(filename)
        Lopt = OptLocScale(4); % for Ne = 40;
        PGaussLoc = getCov(2*Nx, Lopt, "singleScale");
        hold on, plot(PGaussLoc(Nx+1:end,300)','-','Color',Color(11,:),'LineWidth',3)
        
        %% correlation
        plot(rxy,'k')
        
        ylabel('Wind')
        ylim([-1 1])
    elseif expType == "singleScale"
        rxy = P(:,100);
        figure
        set(gcf,'Color','w')
        set(gca,'FontSize',16)
        xlabel('Grid point')
        box off
        title(TitleName{kk})
        
        %% prior loc
        aopt = (rxy.^2*(Ne-1))./(1+Ne*rxy.^2);
        hold on, plot(aopt','-','Color',Color(7,:),'LineWidth',3)
        
        %% posterior loc
        num = rxy.^2*( 1+2*sy^2*b* (sy^2*b-1)/(Ne-1) );
        den = rxy.^2 + 1/(Ne-1) * ( 1+rxy.^2*(1+2*b*sy^2*(3*b*sy^2-4)) );
        aopt = num./den;
        hold on, plot(aopt','-','Color',Color(8,:),'LineWidth',3)
        
        %% Flowerdew
        s = 0.5*log((1+rxy)./(1-rxy));
        ss = 1/sqrt(Ne-3);
        tmp1 = tanh(s+ss);
        tmp2 = tanh(s-ss);
        rcGs = 0.5*abs(tmp1-tmp2);
        aopt = (rxy.^2)./(rxy.^2+rcGs.^2);
        hold on, plot(aopt','-','Color',Color(9,:),'LineWidth',3)
        
        %% ELF
        filename = strcat('./ELFs/',expType,'_ELFLoc_L_',num2str(L),'_ObsDist_',num2str(20),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
        load(filename)
        hold on, plot(ElF_alpha(:,6)','-','Color',Color(6,:),'LineWidth',3)
        
        %% Gaussian
        filename = strcat('./TradLocTuning/singleScale_TradLoc_OptLocScale_L_',num2str(L),'_ObsDist_',num2str(2),'_R_',num2str(r),'.mat');
        load(filename)
        Lopt = OptLocScale(4); % for Ne = 40;
        PGaussLoc = getCov(Nx, Lopt, "singleScale");
        hold on, plot(PGaussLoc(:,100)','-','Color',Color(11,:),'LineWidth',3)
        
        %% correlation
        plot(rxy,'k')
        
        ylim([0 1])
        legend('Prior-opt.','Post-opt.','Flowerdew, 2015', 'ELF','Gaussian','Correlation')

        elseif expType == "multiScale"
            rxy = P(:,100);
            figure
            set(gcf,'Color','w')
            set(gca,'FontSize',16)
            xlabel('Grid point')
            box off
            title(TitleName{kk})
            
            %% prior loc
            aopt = (rxy.^2*(Ne-1))./(1+Ne*rxy.^2);
            hold on, plot(aopt','-','Color',Color(7,:),'LineWidth',3)
            
            %% posterior loc
            num = rxy.^2*( 1+2*sy^2*b* (sy^2*b-1)/(Ne-1) );
            den = rxy.^2 + 1/(Ne-1) * ( 1+rxy.^2*(1+2*b*sy^2*(3*b*sy^2-4)) );
            aopt = num./den;
            hold on, plot(aopt','-','Color',Color(8,:),'LineWidth',3)
            
            %% Flowerdew
            s = 0.5*log((1+rxy)./(1-rxy));
            ss = 1/sqrt(Ne-3);
            tmp1 = tanh(s+ss);
            tmp2 = tanh(s-ss);
            rcGs = 0.5*abs(tmp1-tmp2);
            aopt = (rxy.^2)./(rxy.^2+rcGs.^2);
            hold on, plot(aopt','-','Color',Color(9,:),'LineWidth',3)
            
            %% ELF
            filename = strcat('./ELFs/',expType,'_ELFLoc_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(20),'_R_',num2str(r),'_Ne_',num2str(Ne),'.mat');
            load(filename)
            hold on, plot(ElF_alpha(:,6)','-','Color',Color(6,:),'LineWidth',3)
        
            %% Gaussian
            filename = strcat('./TradLocTuning/multiScale_TradLoc_OptLocScale_L1_',num2str(L(1)),'_L2_',num2str(L(3)),'_ObsDist_',num2str(2),'_R_',num2str(r),'.mat');
            load(filename)
            Lopt = OptLocScale(4); % for Ne = 40;
            PGaussLoc = getCov(Nx, Lopt, "singleScale");
            hold on, plot(PGaussLoc(:,100)','-','Color',Color(11,:),'LineWidth',3)
            
            %% correlation
            plot(rxy,'k')
            
            ylim([0 1])
            legend('Prior-opt.','Post-opt.','Flowerdew, 2015', 'ELF','Gaussian','Correlation')

    else
        fprintf('What do you want?')
    end 
        

end





