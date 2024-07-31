function [p_tp1, X_L, error, u_opt] = leaderMPCandUpdateHalt(...
                            plant, x_0, n, m, N, M, optParams, obstacles, qi, U_l_old, crit_dist)

% compute the MPC output
% [qi, ~] = getObstacleInfo(obstacles, x_0(1:2));

% number of obstalces
% [~,M] = size(qi);

% get params
% Q = optParams.Q;
% R = optParams.R;
% P = optParams.P;
u_lim = optParams.u_lim;
phi_dot_lim = optParams.phi_dot_lim;
v_lim = optParams.v_lim;
w_lim = optParams.w_lim;
L = optParams.L;
% p_t = x_0(1:2);
C = optParams.pot_cost;
decay = optParams.pot_decay;

% construct cost weights matrices... should be precompiled
% pe = optParams.precompiledElements;
% P =  pe.P;
% P_bar = pe.P_bar;
% Sd_bar = pe.Sd_bar;
% Td_bar = pe.Td_bar;
% H = Sd_bar'*P_bar'*P_bar*Sd_bar;
% f = 2*Sd_bar'*P_bar'*P_bar*Td_bar*x_0;
T_bar = getTbar(plant.A, N);
S_bar = getSbar(plant.A, plant.B, N);

% get constraints matrices
[G,W,S] = rigidBodyConstraints(plant.A, plant.B, N, u_lim, phi_dot_lim, v_lim, w_lim);
% realaboration of matrices for quadprog function 
Ac = G;    bc = W + S*x_0;

% perform quadratic optimization
% options =  optimset('Display','off');
% [u_opt, ~, exitflag, output, ~] = quadprog(H, f, Ac, bc, [], [], [], [], U_l_old, options);
% u_opt_reshaped = reshape(u_opt,[m,N]);
% 
% error.QPexitflag = exitflag;
% error.QPoutput = output;

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
             @(U) leaderCostFunHalt(U, x_0, T_bar, S_bar, C, decay, optParams.initRobotShape, M, L, N, n, obstacles, crit_dist),...
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

