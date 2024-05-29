function [p_tp1, X_F, qi, error, u_opt] = followerMPCandUpdate(...
                            plant, XL, x0, N, params, obstacles, U_f_old)

    [qi, ~] = getObstacleInfo(obstacles, x0(1:2));
    %material point:
    %[G,W,S] = constraints(plant.A, plant.B, x0, qi, N, params.u_lim, params.v_lim);
    %rigidBody:
    [G,W,S] = rigidBodyConstraints(plant.A, plant.B, x0, qi, N, params.u_lim, params.v_lim, params.robotShape);
    
    pe = params.precompiledElements;
    h = XL - pe.T_bar*x0;
    
    options = optimoptions('fmincon','Algorithm','active-set',...
        'OptimalityTolerance',1e-1, 'SpecifyObjectiveGradient',true,...
        'Display', 'none'); 
    [u_opt] = fmincon(...
         @(U) followerCostGradientHessian(U,x0,h, pe),...
         U_f_old, G, W + S*x0, [], [], [], [], [], options);
     u_opt_reshaped = reshape(u_opt,[2,N]);

    % model dynamics update, needed to give path intention to plotter
    p_pred = zeros([4, N]); % will have x(1)..x(N)
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