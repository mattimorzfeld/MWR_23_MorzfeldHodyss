function rmse = ExpsPostLoc_seq(noe,Ne,u,l,r,H,L,Xt,Y,expType,noMeanSampling)

ny = length(Y(:,1));
nx = length(Xt(:,1));
nx2 = nx;
if expType == "mcD"
    nx = nx/2;
    nx2 = 2*nx; 
end
P = getCov(nx, L, expType);
sigx = diag(sqrt(diag(P)));
sigy = diag(sqrt(diag(H*P*H')));
CorrMatrix = sigx\(P*H')/sigy;

% CorrMatrix = corrcov(P);
% obsDist = nx/size(H,1);

rmse = zeros(1,noe);

for kk=1:noe
    
    xt = Xt(:,kk);
    y = Y(:,kk);
    
    X1f = getSamples(Ne,u,l);
    if noMeanSampling == 0
        X1m = mean(X1f')';
        X1f = X1f - X1m;
    end
    for jj = 1:ny
%         obLoc = H(jj, :) == 1;
%         obLoc = (jj-1)*obsDist+1;
        dens = H(jj,:)*X1f;
        HPH = var(dens);
        obs = y(jj);
        prior_mean = mean( dens );
        obs_var = r;
        prior_var = HPH;
        
        % subroutine obs_increment_eakf
        var_ratio = obs_var / (prior_var + obs_var);
        new_mean  = var_ratio * (prior_mean  + prior_var*obs / obs_var);
        a         = sqrt(var_ratio);
        obs_inc   = a * (dens - prior_mean) + new_mean - dens;
        
        % subroutine update_from_obs_inc
        obs_prior_mean = prior_mean;
        obs_prior_var  = HPH;
        xs = X1f;

        for oo = 1:nx2
            state          = X1f(oo,:);
            state_mean     = mean( X1f(oo,:) );
            obs_state_cov  = sum( (state-state_mean).*(dens-obs_prior_mean) )/(Ne-1);
            reg_coef       = obs_state_cov/obs_prior_var;
            
            % localization
            c = CorrMatrix(oo,jj);
            sy2 = HPH;
            b = 1/(sy2+r);
            num = c^2*( 1+2*sy2*b* (sy2*b-1)/(Ne-1) );
            den = c^2 + 1/(Ne-1) * ( 1+c^2*(1+2*b*sy2*(3*b*sy2-4)) );
            al = num/den;
             
            state_inc      = al*reg_coef*obs_inc;
            xs(oo,:)       = xs(oo,:) + state_inc;
        end
        X1f = xs;
    end
    xa = mean(X1f,2);
    rmse(kk) = sqrt(sum((xa-xt).^2)/nx2);
end
