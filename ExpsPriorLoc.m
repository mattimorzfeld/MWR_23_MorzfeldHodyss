function rmse = ExpsPriorLoc(noe,Ne,u,l,r,H,L,Xt,Y,expType,normLoc,noMeanSampling)

ny = length(Y(:,1));
nx = length(Xt(:,1));
if expType == "mcD"
    nx = nx/2;
end
P = getCov(nx, L, expType);
C = corrcov(P);
LocP = (Ne-1)*C.^2 ./ (1 + Ne*C.^2);
if normLoc
    LocP = LocP/max(max(LocP));
end
rmse = zeros(1,noe);
for kk=1:noe
    xt = Xt(:,kk);
    y = Y(:,kk);
    Z = getSamples(Ne,u,l);
    Zmean = noMeanSampling*mean(Z,2);
    B = cov(Z');
    BL = LocP.*B;
    K = (BL*H')/(H*BL*H' + r*eye(ny));
    xa = Zmean + K*(y - H*Zmean);
    rmse(kk) = sqrt(mean((xa-xt).^2));
end

