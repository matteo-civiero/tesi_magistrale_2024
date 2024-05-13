function [p_tp1, X_L, qi, error, u_opt] = leaderMPCandUpdateHalt(...
                            plant, x_0, N, optParams, obstacles, U_l_old)

% compute the MPC output
[qi, ~] = getObstacleInfo(obstacles, x_0(1:2));

% get params
Q = optParams.Q;
R = optParams.R;
P = optParams.P;
u_lim = optParams.u_lim;
v_lim = optParams.v_lim;

% construct cost weights matrices... should be precompiled
pe = optParams.precompiledElements;
P =  pe.P;
P_bar = pe.P_bar;
Sd_bar = pe.Sd_bar;
Td_bar = pe.Td_bar;
H = Sd_bar'*P_bar'*P_bar*Sd_bar;
f = 2*Sd_bar'*P_bar'*P_bar*Td_bar*x_0;

% get constraints matrices
[G,W,S] = rigidBodyConstraints(plant.A, plant.B, x_0, qi, N, u_lim, v_lim, optParams.robotShape);
% realaboration of matrices for quadprog function 
Ac = G;    bc = W + S*x_0;

% perform quadratic optimization
options =  optimset('Display','off');
[u_opt, ~, exitflag, output, ~] = quadprog(H, f, Ac, bc, [], [], [], [], U_l_old, options);
u_opt_reshaped = reshape(u_opt,[2,N]);

error.QPexitflag = exitflag;
error.QPoutput = output;


% model dynamics update, needed to give path intention to follower
p_pred = zeros([4, N]); % will have x(1)..x(N)
% first state is x(1), not x(0)
[~, p_pred(:,1)] = modelDynamics(plant, x_0, u_opt_reshaped(:,1));
for j=2:N % note that indexes for u lag one behind in real therms
    [~, p_pred(:,j)] = modelDynamics(plant, p_pred(:,j-1), u_opt_reshaped(:,j));
end

% update the state and input with the first one predicted
p_tp1 = p_pred(:,1);
X_L = p_pred;

    
end

