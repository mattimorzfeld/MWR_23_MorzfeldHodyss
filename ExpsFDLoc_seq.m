function rmse = ExpsFDLoc_seq(noe,Ne,u,l,r,H,L,Xt,Y,expType,noMeanSampling)

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

rmse = zeros(1,noe);

% obsDist = nx/size(H,1);

for kk=1:noe
    if mod(kk,1e3)==0
        fprintf('Exp. %g/%g\n',kk,noe)
    end

    xt = Xt(:,kk);
    y = Y(:,kk);
    
    X1f = getSamples(Ne,u,l);
    if noMeanSampling == 0
        X1m = mean(X1f')';
        X1f = X1f - X1m;
    end
    
    for jj = 1:ny
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
        % localization
        for oo = 1:nx2
            state          = X1f(oo,:);
            state_mean     = mean( X1f(oo,:) );
            obs_state_cov  = sum( (state-state_mean).*(dens-obs_prior_mean) )/(Ne-1);
            reg_coef       = obs_state_cov/obs_prior_var;
            
            % localization
            c = CorrMatrix(oo,jj);
            
            s = 0.5*log((1+c)/(1-c));
            ss = 1/sqrt(Ne-3);
            tmp1 = tanh(s+ss);
            tmp2 = tanh(s-ss);
            rcGs = 0.5*abs(tmp1-tmp2);
            al = (c^2)/(c^2+rcGs^2);
                        
            state_inc      = al*reg_coef*obs_inc;
            xs(oo,:)       = xs(oo,:) + state_inc;
        end
        X1f = xs;
        
    end
    xa = mean(X1f,2);
    rmse(kk) = sqrt(sum((xa-xt).^2)/nx2);
    
end