function C = getCov(Nx, L, expType)
if expType == "singleScale"
    C = spectralCov(Nx, L);
elseif expType == "multiScale"
    C1 = spectralCov(Nx, L(1));
    C2 = spectralCov(Nx, L(3));
    C = L(2)*C1 + L(4)*C2;
elseif expType == "mcD"
    C = spectralCov(Nx, L);
    % derivative operator
    D = zeros(Nx, Nx);
    D(1, Nx) = -1.0;
    D(1, 2) = 1.0;
    for j = 2:Nx-1
        D(j, j-1) = -1.0;
        D(j, j+1) = 1.0;
    end
    D(Nx, 1) = 1.0;
    D(Nx, Nx-1) = -1.0;
    D = 4*D;
    % form 2-variable matrix
    C = [C D*C; C*D' D*C*D'];
elseif expType == "NonStat"
    C = getCov_nonstationary(Nx);
else
    disp("Wrong expType = ", expType)
    C = zeros(Nx);
end
