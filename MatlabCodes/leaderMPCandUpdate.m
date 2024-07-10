function [p_tp1, X_L, qi, error, u_opt] = leaderMPCandUpdate(...
                            plant, p_t, n, m, N, optParams, obstacles, U_l_old)
 
% p_t is the actual state of the agent x(0)
% compute the MPC output
[qi, ~] = getObstacleInfo(obstacles, p_t(1:2));
[~, M] = size(qi);

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
T_bar = optParams.precompiledElements.T_bar;
S_bar = optParams.precompiledElements.S_bar;
L = optParams.L;

% construct cost weights matrices... should be precompiled (pdf)
[H,F,~] = costWeights(plant.A,plant.B,Q,R,P,N);

% get constraints matrices
[G,W,S] = rigidBodyConstraints(plant.A, plant.B, p_t, qi, N, u_lim, phi_dot_lim, v_lim, w_lim, optParams.robotShape);

%realaboration of matrices for quadprog function 
f = F'*p_t;
Ac = G;    bc = W + S*p_t;

% perform quadratic optimization
% options =  optimset('Display','off');
% [u_opt, ~, exitflag, output, ~] = quadprog(H, f, Ac, bc, [], [], [], [], U_l_old, options); % input horizon
% u_opt_reshaped = reshape(u_opt,[m,N]);
% 
% error.QPexitflag = exitflag;
% error.QPoutput = output;

% perform minimization with fmincon in order to use a functional cost for
% the distance between leader and obstalces
options = optimoptions('fmincon','Algorithm','active-set',...
        'OptimalityTolerance',1e-1, 'SpecifyObjectiveGradient',false,...
        'Display', 'none'); % chiediamo il gradiente nelle options !!!!!!!!!!!!!
[u_opt] = fmincon(...
         @(U) leaderCostFun(U, H, f, p_t, T_bar, S_bar, C, decay, optParams.initRobotShape, M, L, N, n, obstacles),...
         U_l_old, Ac, bc, [], [], [], [], ...
         @(U) non_linear_constr(U, qi, p_t, N, n, M, L, optParams.initRobotShape, T_bar, S_bar), options);
u_opt_reshaped = reshape(u_opt,[m,N]); 

error = 0;

% model dynamics update, needed to give path intention to follower
p_pred = zeros([n, N]); % will have x(1)..x(N)
% first state is x(1), not x(0)
[~, p_pred(:,1)] = modelDynamics(plant, p_t, u_opt_reshaped(:,1));
for j=2:N % note that indexes for u lag one behind in real therms
    [~, p_pred(:,j)] = modelDynamics(plant, p_pred(:,j-1), u_opt_reshaped(:,j));
end

% update the state and input with the first one predicted
p_tp1 = p_pred(:,1);
X_L = p_pred;
    
end

