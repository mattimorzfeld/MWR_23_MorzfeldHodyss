function rmse = ExpsTradLoc(noe,Ne,Lloc,u,l,L,r,H,Xt,Y,expType,noMeanSampling)

ny = length(Y(:,1));
nx = length(Xt(:,1));
rmse = zeros(1,noe);
x = (1:nx)';

if expType == "mcD"
    Loc = getCov(nx/2, Lloc, "singleScale");
    LocP = [Loc Loc; Loc Loc];
else
    LocP = getCov(nx, Lloc, "singleScale");
end

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

