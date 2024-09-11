function [p_tp1, X_L, error, u_opt] = leaderMPCandUpdate(...
                            plant, p_t, n, m, N, M, optParams, obstacles, qi, U_l_old, crit_dist, fixed_horizon, alg_fmincon, sigma_2, sim_noise)
% execute the MPC for the leader

% get params
Q = optParams.Q;
R = optParams.R;
P = optParams.P;
u_lim = optParams.u_lim;
phi_dot_lim = optParams.phi_dot_lim;
v_lim = optParams.v_lim;
w_lim = optParams.w_lim;
C = optParams.pot_cost;
decay = optParams.pot_decay;
if fixed_horizon
    T_bar = optParams.precompiledElements.T_bar;
    S_bar = optParams.precompiledElements.S_bar;
else
    T_bar = getTbar(plant.A, N);
    S_bar = getSbar(plant.A, plant.B, N);
end
L = optParams.L;

% construct cost weights matrices... should be precompiled (pdf)
[H,F,~] = costWeights(plant.A,plant.B,Q,R,P,N);

% get constraints matrices
[G,W,S] = rigidBodyConstraints(N, u_lim, phi_dot_lim, v_lim, w_lim, n, S_bar, T_bar);

%realaboration of matrices for quadprog function 
f = F'*p_t;
Ac = G;    bc = W + S*p_t;

% perform minimization with fmincon in order to use a functional cost for
% the distance between leader and obstalces
options = optimoptions('fmincon','Algorithm',alg_fmincon,...
        'OptimalityTolerance',1e-1, 'SpecifyObjectiveGradient',false,...
        'Display', 'none');
if crit_dist
    [u_opt] = fmincon(...
             @(U) leaderCostFun(U, H, f, p_t, T_bar, S_bar, C, decay, optParams.initRobotShape, M, L, N, n, obstacles, crit_dist),...
             U_l_old, Ac, bc, [], [], [], [], ...
             @(U) non_linear_constr_leader(U, qi, p_t, N, n, M, L, optParams.initRobotShape, T_bar, S_bar), options);
else
    [u_opt] = fmincon(...
             @(U) leaderCostFun(U, H, f, [], [], [], [], [], [], [], [], [], [], [], crit_dist),...
             U_l_old, Ac, bc, [], [], [], [], [], options);
end

u_opt_reshaped = reshape(u_opt,[m,N]); 

error = 0;

% model dynamics update, needed to give path intention to follower
p_pred = zeros([n, N]); % will have x(1)..x(N)
% first state is x(1), not x(0)
[~, p_pred(:,1)] = modelDynamics(plant, p_t, u_opt_reshaped(:,1), sigma_2, sim_noise);
for j=2:N % note that indexes for u lag one behind in real therms
    [~, p_pred(:,j)] = modelDynamics(plant, p_pred(:,j-1), u_opt_reshaped(:,j), sigma_2, sim_noise);
end

% update the state and input with the first one predicted
p_tp1 = p_pred(:,1);
X_L = p_pred;
    
end

