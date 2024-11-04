function [p_tp1, X_F, error, u_opt] = followerMPCandUpdate(...
                            A, B, C, D, XL, x0, n, m, N, M, q_load, params, obstacles, qi, U_f_old, loadTheta0, crit_dist, fixed_horizon, alg_fmincon)

    % function that computes the MPC for the follower

    % parameters
    pe = params.precompiledElements;
    if fixed_horizon
        T_bar = pe.T_bar;
        S_bar = pe.S_bar;
        Sd_bar = pe.Sd_bar;
        Td_bar = pe.Td_bar;
    else
        T_bar = getTbar(A, N);
        S_bar = getSbar(A, B, N);
        Sd_bar = getSdbar(A, B, N);
        Td_bar = getTdbar(A, N);
    end
    h = XL - T_bar*x0;
    C = params.pot_cost;
    decay = params.pot_decay;

    %rigidBodyConstraints (velocity and acceleration) 
    [G,W,S] = rigidBodyConstraints(N, params.u_lim, params.phi_dot_lim, params.v_lim, params.w_lim, n, S_bar, T_bar);
    
    % optimization
    options = optimoptions('fmincon','Algorithm',alg_fmincon,...
        'OptimalityTolerance',1e-1, 'SpecifyObjectiveGradient', true,...
        'Display', 'none');
    
    if crit_dist
        [u_opt] = fmincon(...
             @(U) followerCostGradientHessian(U, x0, n, m, N, h, pe, params.vertexes, M, params.initRobotShape, obstacles, C, decay, params.R, T_bar, S_bar, Td_bar, Sd_bar, crit_dist, fixed_horizon),...
             U_f_old, G, W + S*x0, [], [], [], [], ...
             @(U) non_linear_constr_follower(U, qi, q_load, x0, N, n, M, params.vertexes, params.L, params.initRobotShape, params.initLoadShape, params.loadCenter, T_bar, S_bar, XL, loadTheta0), options);
    else
        [u_opt] = fmincon(...
             @(U) followerCostGradientHessian(U, x0, n, m, N, h, pe, [], [], [], [], [], [], params.R, [], S_bar, Td_bar, Sd_bar, crit_dist, fixed_horizon),...
             U_f_old, G, W + S*x0, [], [], [], [], [], options);

    end
    u_opt_reshaped = reshape(u_opt,[m,N]); 

    % model dynamics update, needed to give path intention to plotter
    p_pred = zeros([n, N]); % will have x(1)..x(N) 
    % first state is x(1), not x(0)
    [~, p_pred(:,1)] = modelDynamics(A, B, C, D, x0, u_opt_reshaped(:,1));
    for j=2:N % note that indexes for u lag one behind in real therms
        [~, p_pred(:,j)] = modelDynamics(A, B, C, D, p_pred(:,j-1), u_opt_reshaped(:,j));
    end

    % update the state and input with the first one predicted
    p_tp1 = p_pred(:,1);
    X_F = p_pred;

    error = 0;

end