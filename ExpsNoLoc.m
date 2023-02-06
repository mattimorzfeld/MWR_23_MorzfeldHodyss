function rmse = ExpsNoLoc(noe,Ne,u,l,r,H,Xt,Y,expType,noMeanSampling)

ny = length(Y(:,1));
nx = length(Xt(:,1));
if expType == "mcD"
    nx = nx/2;
end
rmse = zeros(1,noe);
for kk=1:noe
    xt = Xt(:,kk);
    y = Y(:,kk);
    Z = getSamples(Ne,u,l);
    Zmean = noMeanSampling*mean(Z,2);
    B = cov(Z');
    K = (B*H')/(H*B*H' + r*eye(ny));
    xa = Zmean + K*(y - H*Zmean);
    rmse(kk) = sqrt(mean((xa-xt).^2));
end

