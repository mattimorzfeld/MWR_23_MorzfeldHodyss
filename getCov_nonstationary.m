function C = getCov_nonstationary(n)

dx = 1;
a = .1;
b = 2;

C = zeros(n);
x = (1:n)*dx;
ell = a*x+b;

for ii=1:n
    for jj=ii:n
        dist = abs(ii-jj)*dx;
        lii = ell(ii);
        ljj = ell(jj);
        C(ii,jj) = (lii*ljj)^(1/4)/sqrt(mean([lii ljj])) * exp(-abs(dist/(mean([lii ljj])))^2);
    end
end

C = (C+C')-diag(diag(C));

