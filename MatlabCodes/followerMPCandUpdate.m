function [p_tp1, X_F, error, u_opt] = followerMPCandUpdate(...
                            plant, XL, x0, n, m, N, M, params, obstacles, qi, U_f_old, loadTheta, leaderParams, crit_dist)

    % nearest obstacle point to load (for constraints)
    [q_load, ~] = getObstacleInfo(obstacles, x0(1:2) + Rmat(loadTheta) * params.loadCenter); % loadCenter rotates with load
    
    % parameters
    pe = params.precompiledElements;
    T_bar = getTbar(plant.A, N);
    S_bar = getSbar(plant.A, plant.B, N);
    Sd_bar = getSdbar(plant.A, plant.B, N);
    Td_bar = getTdbar(plant.A, N);
    h = XL - T_bar*x0;
    C = params.pot_cost;
    decay = params.pot_decay;

    %rigidBody:
    [G,W,S] = rigidBodyConstraints(N, params.u_lim, params.phi_dot_lim, params.v_lim, params.w_lim, n, S_bar, T_bar);
    
    % optimization
    options = optimoptions('fmincon','Algorithm','active-set',...
        'OptimalityTolerance',1e-1, 'SpecifyObjectiveGradient', true,...
        'Display', 'none');

    if crit_dist
        [u_opt] = fmincon(...
             @(U) followerCostGradientHessian(U, x0, n, m, N, h, pe, params.vertexes, M, params.initRobotShape, obstacles, C, decay, params.R, T_bar, S_bar, Td_bar, Sd_bar, crit_dist),...
             U_f_old, G, W + S*x0, [], [], [], [], ...
             @(U) non_linear_constr_follower(U, qi, q_load, x0, N, n, M, params.vertexes, params.L, params.initRobotShape, params.initLoadShape, params.loadCenter, T_bar, S_bar, XL, leaderParams), options);
    else
        [u_opt] = fmincon(...
             @(U) followerCostGradientHessian(U, x0, n, m, N, h, pe, [], [], [], [], [], [], params.R, [], S_bar, Td_bar, Sd_bar, crit_dist),...
             U_f_old, G, W + S*x0, [], [], [], [], [], options);

    end
    u_opt_reshaped = reshape(u_opt,[m,N]); 

    % model dynamics update, needed to give path intention to plotter
    p_pred = zeros([n, N]); % will have x(1)..x(N) 
    % first state is x(1), not x(0)
    [~, p_pred(:,1)] = modelDynamics(plant, x0, u_opt_reshaped(:,1));
    for j=2:N % note that indexes for u lag one behind in real therms
        [~, p_pred(:,j)] = modelDynamics(plant, p_pred(:,j-1), u_opt_reshaped(:,j));
    end

    % update the state and input with the first one predicted
    p_tp1 = p_pred(:,1);
    X_F = p_pred;

    error = 0;

end