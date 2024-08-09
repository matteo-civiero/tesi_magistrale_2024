function [f, g] = followerCostGradientHessian(U, x0, n, m, N, h, pe, L, M, vertexes, obstacles, C, decay, R, T_bar, S_bar, Td_bar, Sd_bar, crit_dist, fixed_horizon)

    % Computes functional cost f and gradient g of the follower
    
    P = pe.P;
    if fixed_horizon
        P_bar = pe.P_bar;
        beta_vec = pe.beta_vec;
    else
        P_bar = kron(eye(N), P);
        beta_vec = pe.beta .^ (0:(N-1))';
    end
    
    f1= (P_bar*(Sd_bar*U + Td_bar*x0))'*(P_bar*(Sd_bar*U + Td_bar*x0)); % cost function (33)
    SU = reshape(S_bar * U, [n, N]); 
    H = reshape(h, [n, N]); 
    HmSU = H-SU;
    PHmSU = P*HmSU;
    P_LmF_norms = vecnorm(PHmSU)' .^2; % transpose to make it vector
    d_LF_vec = pe.d^2 * ones([N, 1]); % vector of distances stacked
    f2 = sum( beta_vec .* ( P_LmF_norms - d_LF_vec) .^ 2 ); % cost function (29)
    
    % function for potential repulsion
    f3 = 0;
    if crit_dist
        x_t = (T_bar * x0 + S_bar * U);
        for i = 1:M
            for j = 1:L
                for t = 1:N
                    % x_t((n*(t-1)+1):(n*t-(n-2)) is position(t)
                    f3 = f3 + C * exp(-decay * (norm(x_t((n*(t-1)+1):(n*t-(n-2))) + Rmat(x_t(n*t-(n-3))) * vertexes(:,j) - obstacles{i}.center) - obstacles{i}.radius));
                end
            end
        end
    end
    
    % follower effort cost function
    R_eff = kron(eye(N), R);
    f4 = U' * R_eff * U;

    f = f1 + pe.C*f2 + f3 + f4; % total cost function

    if nargout > 1 % gradient required
        M_tot = reshape(HmSU, [n*N, 1]);
        PM_tot = P_bar*M_tot;
        g1 = 2*Sd_bar' * (P_bar' * P_bar) * (Td_bar*x0 + Sd_bar*U);

        g2 = zeros([m*N, 1]); 
        for t = 1:N
            Sbar_t = S_bar( n*t-(n-1) : n*t, :); 
            pm_t = PM_tot((2*t-1 : 2*t)); 
            g2 = g2 + ...
            beta_vec(t) * (-4) * ( norm(pm_t)^2 - pe.d^2 ) * Sbar_t' * P' * pm_t;
        end
        
        g3 = zeros([m*N, 1]);
        if crit_dist
            % creation of F and G matrixes for correct instant selection
            F = cell(N);
            G = cell(N);
            for t = 1:N
                F{t} = zeros([2, n*N]);
                F{t}(1, n*(t-1) + 1) = 1;
                F{t}(2, n*(t-1) + 2) = 1;
                G{t} = zeros([1, n*N]);
                G{t}(1, n*(t-1) + 3) = 1;
            end
            
            % g3 calc
            for i = 1:M
                for j = 1:L
                    for t = 1:N
                        mat_nd = [cos(G{t} * x_t)*vertexes(1, j) - sin(G{t} * x_t)*vertexes(2, j); 
                            sin(G{t} * x_t)*vertexes(1, j) + cos(G{t} * x_t)*vertexes(2, j)];
                        mat_d = [-sin(G{t} * x_t)*vertexes(1, j) - cos(G{t} * x_t)*vertexes(2, j); 
                            cos(G{t} * x_t)*vertexes(1, j) - sin(G{t} * x_t)*vertexes(2, j)];
                        D = F{t} * x_t + mat_nd - obstacles{i}.center;
                        
                        g3 = g3 - decay * C * exp(-decay * (norm(D) - obstacles{i}.radius)) * (S_bar' * F{t}' + S_bar' * G{t}' * mat_d') * D / norm(D);
                    end
                end
            end
        end
        
        g4 = 2 * R_eff * U;

        g = g1 + pe.C*g2 + g3 + g4;

    end