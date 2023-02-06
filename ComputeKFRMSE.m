% ComputeKFError
if expType == "multiScale"
    filename = strcat('./SynthData/',expType,'_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    load(filename,'Xt','Y','H','L')
    nx = size(Xt,1);
elseif expType == "NonStat"
    filename = strcat('./SynthData/',expType,'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    load(filename,'Xt','Y','H','L')
else
    filename = strcat('./SynthData/',expType,'_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    load(filename,'Xt','Y','H','r','L')
end
nx = size(Xt,1);
if expType == "mcD"
    nx = nx/2;
end

ny = size(Y,1);
noe = size(Xt,2);
P = getCov(nx, L, expType);

% K = P*H'/(H*P*H'+r*eye(ny));
% if expType == "mcD"
%     Ppost = (eye(2*nx) -K*H)*P;
% else
%     Ppost = (eye(nx) -K*H)*P;
% end
% rmseKF = sqrt(trace(Ppost)/length(Ppost))

for oo=1:noe
    xKF = P*H'*((H*P*H'+r*eye(ny))\Y(:,oo));
    rmseKF(oo) = sqrt(mean((xKF-Xt(:,oo)).^2));
end
rmseKF = mean(rmseKF)