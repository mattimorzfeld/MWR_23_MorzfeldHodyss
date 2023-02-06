function C = spectralCov(Nx, L)
% create sinusoid matrix (basis functions)
% ... Nx must be even
% ... because we use sinusoids our correlation matrix will be periodic
E = zeros(Nx, Nx);
dz = 2*pi/Nx;
zj = [dz:dz:2*pi]';
E(:, 1) = ones(Nx, 1)/sqrt(Nx);
for i = 1:(Nx/2-1)
    tt = cos(i*zj);
    tn = sqrt(tt'*tt);
    E(:, 2*i) = tt/tn;
    tt = sin(i*zj);
    tn = sqrt(tt'*tt);
    E(:, 2*i+1) = tt/tn;
end
tt = cos(Nx*zj/2);
tn = sqrt(tt'*tt);
E(:, Nx) = tt/tn;
% create eigenvalues
b = 2*(pi*L/Nx)^2;
g = ones(Nx,1);
for i = 1:(Nx/2-1)
   g(2*i) = exp(-b*i^2);
   g(2*i+1) = g(2*i);
end
g(Nx) = exp(-b*(Nx/2)^2);
a = Nx/sum(g);
g = a*g;
G = diag(g);
C = E*G*E';
C = (C+C')/2;
