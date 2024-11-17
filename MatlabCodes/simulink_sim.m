clear all;
close all;

leader_mass = 1;
follower_mass = 1;
leader_inertia = 0.166667;
follower_inertia = 0.015;
n = 6;
m = 3;
Ts = 0.1; % sample time
A = [zeros(3,3), eye(3);
     zeros(3,3), zeros(3,3)]; % state matrix
B = [zeros(3,3); eye(3)];
C = eye(n);
D = zeros([n, m]);

% continuous-time system
plantc = ss(A,B,C,D);
% discrete-time system
plant = c2d(plantc, Ts, 'zoh'); % exact discretization

env_name = "three_obs";
[x0, obstacles] = setupEnvironment(env_name);
[~, M] = size(obstacles);
if M > 0
    for i=1:M
        obs_centers(:,i) = obstacles{i}.center(:);
        obs_radius(i) = obstacles{i}.radius;
        obs_velocities(:,i) = obstacles{i}.velocity(:);
    end
    obs_centers = reshape(obs_centers, [1 2*M]);
    obs_velocities = reshape(obs_velocities, [1 2*M]);
else
    obs_centers = [];
    obs_radius = [];
    obs_velocities = [];
end

x_l_0 = x0;
x_f_0 = x0 + [1; 0; 0; 0; 0; 0]; % at initial condition we have horizontal disposition with d_FL distance

alg_fmincon = 'sqp';
fixed_horizon = false;
sim_perception_range = true;
eps_loose_grip = 0.05;

N_short = 5;
N_long = 15;
N_fixed = 15;

% COMMON PARAMETERS 
% weight for intermediate states
Q_weight = diag([1, 1, 10, 1, 1, 10]); 
% weight for inputs
R_weight = diag([0.9, 0.9, 0.9]); 
% weight for last state only
P_weight = diag([500, 500, 100, 100, 100, 100]);

P = [1 0 0 0 0 0; 0 1 0 0 0 0]; % selects x and y

% Policy params
policy_halt = true;
k_loose_grip = 3;   % recovery policy horizon

% LEADER PARAMETERS
% leader weights
leaderParams.Q = Q_weight*eye(n);       
leaderParams.R = R_weight*eye(m);
leaderParams.P = P_weight*eye(n);

% limit on leader acceleration, both x and y axes and angular acc
leaderParams.u_lim = 5; % [m/s^2]
leaderParams.phi_dot_lim = 10; % [rad/s^2]

% limit on leader velocity, both x and y axes
leaderParams.v_lim = 1; % [m/s]
leaderParams.w_lim = 1.57; % [rad/s]

% decay and cost parameters for obstacle distance
leaderParams.pot_decay = 10;
leaderParams.pot_cost = 125;

% initial shape of leader
leaderParams.initRobotShape = 0.3*[-1, 1, 1, -1; -1, -1, 1, 1]; % square robot
% leaderParams.initRobotShape = [-0.01, 0.01, 0.01, -0.01; 0.8, 0.8, -0.8, -0.8]; % bar robot
% number of vertexes
[~, leaderParams.vertexes] = size(leaderParams.initRobotShape);
%leaderParams.robotShape = leaderParams.initRobotShape;
[~ , leaderParams.L] = size(leaderParams.initRobotShape);

% leader max radius
leaderParams.max_radius = max_radius(leaderParams.initRobotShape, leaderParams.vertexes) * 1.1;
% maximum distance for repulsive potential calculation
leaderParams.rep_dist_c = 3;
leaderParams.rep_dist = leaderParams.rep_dist_c * (leaderParams.max_radius + 0.5 * power(leaderParams.v_lim, 2) / leaderParams.u_lim);


% FOLLOWER PARAMETERS
% relative distance from leader to follower to have (between the center of
% mass of the robots)
followerParams.d_FL = 1;

% relative cost for distance errors
followerParams.C = 5000; 

% limit on follower acceleration, to be higher than leader
followerParams.u_lim = 7; % [m/s^2]
followerParams.phi_dot_lim = 20; % [rad/s^2]

% limit on follower velocity, to be higher than leader
followerParams.v_lim = 1.5; % [m/s]
followerParams.w_lim = 3.14; % [rad/s]

% exponential decay of tracking quality over the prediction
followerParams.beta = 0.95;

% same obstacle avoidance parameters
followerParams.pot_decay = leaderParams.pot_decay;
followerParams.pot_cost = leaderParams.pot_cost;

% effort cost of follower
followerParams.R = diag([1, 1, 1]);

% follower shape
followerParams.initRobotShape = 0.15*[-1, 1, 1, -1; -1, -1, 1, 1];
% number of vertexes of the robot not including load
[~, followerParams.vertexes] = size(followerParams.initRobotShape);

% load shape
followerParams.initLoadShape = (0.1*[-1, 1, 1, -1; -1, -1, 1, 1] ...
    +followerParams.d_FL*[-1, 0, 0, -1; 0, 0, 0, 0]);
followerParams.loadCenter = [-followerParams.d_FL/2; 0];

% robot shape contains the actual robot shape and the load shape
followerParams.robotShape = [followerParams.initRobotShape, followerParams.initLoadShape];
% number of vertexes of the robot including load
[~ , followerParams.L] = size(followerParams.robotShape);

% follower max radius
followerParams.max_radius = max_radius(followerParams.initRobotShape, followerParams.vertexes) * 1.1;
% maximum distance for repulsive potential calculation
followerParams.rep_dist_c = 3;
followerParams.rep_dist = followerParams.rep_dist_c * (followerParams.max_radius + 0.5 * power(followerParams.v_lim, 2) / followerParams.u_lim);

% perception range of the system, measured from load center
perception_range_c = 4;
perception_range = perception_range_c * (followerParams.d_FL/2 + max(leaderParams.max_radius, followerParams.max_radius));

followerParams.precompiledElements.d = followerParams.d_FL;
followerParams.precompiledElements.C = followerParams.C;
followerParams.precompiledElements.L = followerParams.L;
followerParams.precompiledElements.M = length(obstacles);
followerParams.precompiledElements.beta = followerParams.beta;
followerParams.precompiledElements.P = P;
if fixed_horizon
    followerParams.precompiledElements.Sd_bar = getSdbar(plant.A, plant.B, N_fixed);
    followerParams.precompiledElements.Td_bar = getTdbar(plant.A, N_fixed);
    followerParams.precompiledElements.S_bar = getSbar(plant.A, plant.B, N_fixed);
    followerParams.precompiledElements.T_bar = getTbar(plant.A, N_fixed);
    followerParams.precompiledElements.H1 = followerParams.precompiledElements.S_bar'*followerParams.precompiledElements.S_bar;
    followerParams.precompiledElements.beta_vec = followerParams.beta .^ (0:(N_fixed-1))';
    followerParams.precompiledElements.P_bar = kron(eye(N_fixed), followerParams.precompiledElements.P);
    leaderParams.precompiledElements.P_bar = kron(eye(N_fixed), followerParams.precompiledElements.P);
    leaderParams.precompiledElements.Sd_bar = followerParams.precompiledElements.Sd_bar;
    leaderParams.precompiledElements.Td_bar = followerParams.precompiledElements.Td_bar;
    leaderParams.precompiledElements.S_bar = followerParams.precompiledElements.S_bar;
    leaderParams.precompiledElements.T_bar = followerParams.precompiledElements.T_bar;
end
leaderParams.precompiledElements.P = P;

if fixed_horizon
    N = N_fixed;
else
    N = N_long;
end
% initial guesses for optimal inputs
U_l_old = zeros([m*N,1]);
U_f_old = zeros([m*N,1]);

%%

load("/home/matteociviero/tesi/sims_w_perc_range_sqp/adaptive_15_5_three_obs_no_plot/data.mat", "x_l", "x_f");

x_l_sim = timeseries(x_l', 0:Ts:(length(x_l)-1)*Ts);
x_f_sim = timeseries(x_f', 0:Ts:(length(x_f)-1)*Ts);