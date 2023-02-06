%%get cov and sampler 
C = getCov(Nx, L, expType);
[u,l]=getSVD(C);

%% obs setup
obsgrid = 1:ObsDist:Nx;
if expType == "mcD"
    if localOb == 0
        H = eye(2*Nx);
        H = H(1:ObsDist:Nx,:);
    else
        H = zeros(length(obsgrid), 2*Nx);
        for jp = 1:length(obsgrid)
            left2 = grdPnt(obsgrid(jp), Nx, -2);
            left1 = grdPnt(obsgrid(jp), Nx, -1);
            right1 = grdPnt(obsgrid(jp), Nx, 1);
            right2 = grdPnt(obsgrid(jp), Nx, 2); 
            H(jp, left2) = 1/5; 
            H(jp, left1) = 1/5;
            H(jp, obsgrid(jp)) = 1/5;
            H(jp, right1) = 1/5;
            H(jp, right2) = 1/5;   
        end
    end
else
    if localOb == 0
        H = eye(Nx);
        H = H(1:ObsDist:end,:);
    else
        H = zeros(length(obsgrid), Nx);
        for jp = 1:length(obsgrid)
            left2 = grdPnt(obsgrid(jp), Nx, -2);
            left1 = grdPnt(obsgrid(jp), Nx, -1);
            right1 = grdPnt(obsgrid(jp), Nx, 1);
            right2 = grdPnt(obsgrid(jp), Nx, 2); 
            H(jp, left2) = 1/5; 
            H(jp, left1) = 1/5;
            H(jp, obsgrid(jp)) = 1/5;
            H(jp, right1) = 1/5;
            H(jp, right2) = 1/5;   
        end
    end
end

Xt = zeros(length(C),noe);
Y = zeros(size(H,1),noe);
for kk=1:noe
    [xt,y] = SynthExp(u,l,r,H);
    Xt(:,kk) = xt;
    Y(:,kk) = y;
end
if localOb == 0
    if expType == "multiScale"
        filename = strcat('./SynthData/',expType,'_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    elseif expType == "NonStat"
        filename = strcat('./SynthData/',expType,'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    else
        filename = strcat('./SynthData/',expType,'_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    end
else
    if expType == "multiScale"
        filename = strcat('./NonLocObsSynthData/',expType,'_L1_', num2str(L(1)),'_L2_', num2str(L(3)),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    elseif expType == "NonStat"
        filename = strcat('./NonLocObsSynthData/',expType,'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    else
        filename = strcat('./NonLocObsSynthData/',expType,'_L_',num2str(L),'_ObsDist_',num2str(ObsDist),'_R_',num2str(r),'.mat');
    end
end
save(filename,'Xt','Y','H','u','l','r','H','L')



function pt = grdPnt(center, Nx, shft)
    pt = mod(center+shft, Nx);
    if pt == 0
        pt = Nx;
    end
end    