function [xt,y] = SynthExp(u,l,r,H)

% truth
xt = getSamples(1,u,l);
% obs
y = H*xt;
y = y + sqrt(r)*randn(length(y),1);