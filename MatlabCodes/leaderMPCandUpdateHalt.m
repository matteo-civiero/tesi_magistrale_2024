function [p_tp1, X_L, error, u_opt] = leaderMPCandUpdateHalt(...
                            plant, x_0, n, m, N, M, optParams, obstacles, qi, U_l_old, crit_dist, fixed_horizon)
% execute the MPC for the leader in feasibility-aware policy

% get params
u_lim = optParams.u_lim;
phi_dot_lim = optParams.phi_dot_lim;
v_lim = optParams.v_lim;
w_lim = optParams.w_lim;
L = optParams.L;
C = optParams.pot_cost;
decay = optParams.pot_decay;

if fixed_horizon
    T_bar = optParams.precompiledElements.T_bar;
    S_bar = optParams.precompiledElements.S_bar;
else
    T_bar = getTbar(plant.A, N);
    S_bar = getSbar(plant.A, plant.B, N);
end

% get constraints matrices
[G,W,S] = rigidBodyConstraints(N, u_lim, phi_dot_lim, v_lim, w_lim, n, S_bar, T_bar);
% realaboration of matrices for quadprog function 
Ac = G;    bc = W + S*x_0;

% perform minimization with fmincon in order to use a functional cost for
% the distance between leader and obstalces
options = optimoptions('fmincon','Algorithm','active-set',...
        'OptimalityTolerance',1e-1, 'SpecifyObjectiveGradient',false,...
        'Display', 'none');

if crit_dist
    [u_opt, ~, exitflag] = fmincon(...
             @(U) leaderCostFunHalt(U, x_0, T_bar, S_bar, C, decay, optParams.initRobotShape, M, L, N, n, obstacles, crit_dist),...
             U_l_old, Ac, bc, [], [], [], [], ...
             @(U) non_linear_constr_leader(U, qi, x_0, N, n, M, L, optParams.initRobotShape, T_bar, S_bar), options);
else
    [u_opt, ~, exitflag] = fmincon(...
             @(U) leaderCostFunHalt(U, x_0, T_bar, S_bar, [], [], [], [], [], N, [], [], crit_dist),...
             U_l_old, Ac, bc, [], [], [], [], [], options);
end

u_opt_reshaped = reshape(u_opt,[m,N]); 

error = exitflag;


% model dynamics update, needed to give path intention to follower
p_pred = zeros([n, N]); % will have x(1)..x(N)
% first state is x(1), not x(0)
[~, p_pred(:,1)] = modelDynamics(plant, x_0, u_opt_reshaped(:,1));
for j=2:N % note that indexes for u lag one behind in real therms
    [~, p_pred(:,j)] = modelDynamics(plant, p_pred(:,j-1), u_opt_reshaped(:,j));
end

% update the state and input with the first one predicted
p_tp1 = p_pred(:,1);
X_L = p_pred;

    
end

