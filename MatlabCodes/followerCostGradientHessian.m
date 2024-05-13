function [f, g] = followerCostGradientHessian(U,x0,h,pe)

    % Calculate objective f
    N = pe.N;
    Sd_bar = pe.Sd_bar;
    Td_bar = pe.Td_bar;
    
    P = pe.P;
    P_bar = pe.P_bar;
    
    f1= (P_bar*(Sd_bar*U + Td_bar*x0))'*(P_bar*(Sd_bar*U + Td_bar*x0));
    SU = reshape(pe.S_bar * U, [4, N]);
    H = reshape(h, [4, N]);
    HmSU = H-SU;
    PHmSU = P*HmSU;
    P_LmF_norms = vecnorm(PHmSU)' .^2; % transpose to make it vector
    d_LF_vec = pe.d^2 * ones([N, 1]); % vector of distances stacked
    f2 = sum( pe.beta_vec .* ( P_LmF_norms - d_LF_vec) .^ 2 );
    
    f = f1 + pe.C*f2;

    if nargout > 1 % gradient required
        M_tot = reshape(HmSU, [4*N, 1]);
        PM_tot = P_bar*M_tot;
        g1 = 2*Sd_bar' * (P_bar' * P_bar) * (Td_bar*x0 + Sd_bar*U);
              
        g2 = zeros([2*N, 1]); 
        for t = 1:N
            Sbar_t = pe.S_bar( 4*t-3 : 4*t, :);
            pm_t = PM_tot((2*t-1 : 2*t));
            g2 = g2 + ...
            pe.beta_vec(t) * (-4) * ( norm(pm_t)^2 - pe.d^2 ) * Sbar_t' * P' * pm_t;
        end
              
        g = g1 + pe.C*g2;

        
    end