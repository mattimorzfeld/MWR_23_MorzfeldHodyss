%% 
clear
close all
clc
Colors

NeAll = logspace(1,4,50);
rxy = 0:.001:1;

APriorOpt=zeros(length(rxy),length(NeAll));
APostOpt=zeros(length(rxy),length(NeAll));
for kk=1:length(NeAll)
    Ne = NeAll(kk);
    APriorOpt(:,kk) = (rxy.^2*(Ne-1))./(1+Ne*rxy.^2);
    APostOpt(:,kk) = (rxy.^2*(Ne-1.5))./(1+(Ne-5/2)*rxy.^2);
end

figure
hold on,plot(rxy,APriorOpt','-','Color',Color(3,:),'LineWidth',1)

set(gcf,'Color','w')
set(gca,'FontSize',15)
xlabel('\rho_{xy} (log scale)')
ylabel('\alpha_{opt}')
hold on, plot([0 1],[1 1],'k--','LineWidth',2)
box off
ylim([0 1])
xlim([1e-2 1])
set(gca,'XScale','log')

Ne = 50;
aopt = (rxy.^2*(Ne-1))./(1+Ne*rxy.^2);
hold on, plot(rxy,aopt','-','Color',Color(1,:),'LineWidth',3)

Ne = 100;
aopt = (rxy.^2*(Ne-1))./(1+Ne*rxy.^2);
hold on, plot(rxy,aopt','-','Color',Color(2,:),'LineWidth',3)

Ne = 500;
aopt = (rxy.^2*(Ne-1))./(1+Ne*rxy.^2);
hold on, plot(rxy,aopt','-','Color',Color(6,:),'LineWidth',3)

Ne = 1000;
aopt = (rxy.^2*(Ne-1))./(1+Ne*rxy.^2);
hold on, plot(rxy,aopt','-','Color',Color(4,:),'LineWidth',3)

hold on
plot([.1 .1],[0 1],'k--')
grid on



figure
hold on,plot(rxy,APostOpt','-','Color',Color(3,:),'LineWidth',1)

set(gcf,'Color','w')
set(gca,'FontSize',15)
xlabel('\rho_{xy} (log scale)')
ylabel('\alpha_{opt}')
hold on, plot([0 1],[1 1],'k--','LineWidth',2)
box off
ylim([0 1])
xlim([1e-2 1])
set(gca,'XScale','log')

Ne = 50;
aopt = (rxy.^2*(Ne-1.5))./(1+(Ne-5/2)*rxy.^2);;
hold on, plot(rxy,aopt','-','Color',Color(1,:),'LineWidth',3)

Ne = 100;
aopt = (rxy.^2*(Ne-1.5))./(1+(Ne-5/2)*rxy.^2);;
hold on, plot(rxy,aopt','-','Color',Color(2,:),'LineWidth',3)

Ne = 500;
aopt = (rxy.^2*(Ne-1.5))./(1+(Ne-5/2)*rxy.^2);;
hold on, plot(rxy,aopt','-','Color',Color(6,:),'LineWidth',3)

Ne = 1000;
aopt = (rxy.^2*(Ne-1.5))./(1+(Ne-5/2)*rxy.^2);;
hold on, plot(rxy,aopt','-','Color',Color(4,:),'LineWidth',3)

hold on
plot([.1 .1],[0 1],'k--')
grid on