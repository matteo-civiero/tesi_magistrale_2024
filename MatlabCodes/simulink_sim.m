clear all;
close all;

n = 6;
m = 3;
Ts = 0.1; % sample time
Ac = [zeros(3,3), eye(3);
     zeros(3,3), zeros(3,3)]; % state matrix
Bc = [zeros(3,3); eye(3)];
Cc = eye(n);
Dc = zeros([n, m]);

% COMMON PARAMETERS 
% weight for intermediate states
Q_weight = diag([1, 1, 10, 1, 1, 10]); 
% weight for inputs
R_weight = diag([0.9, 0.9, 0.9]); 
% weight for last state only
P_weight = diag([500, 500, 100, 100, 100, 100]);
P = [1 0 0 0 0 0; 0 1 0 0 0 0]; % selects x and y

% LEADER PARAMETERS
% leader weights
leaderParams.Q = Q_weight*eye(n);       
leaderParams.R = R_weight*eye(m);
leaderParams.P = P_weight*eye(n);

% limit on leader acceleration, both x and y axes and angular acc
leaderParams.u_lim = 3; % [m/s^2]
leaderParams.phi_dot_lim = 10; % [rad/s^2]

% limit on leader velocity, both x and y axes
leaderParams.v_lim = 1; % [m/s]
leaderParams.w_lim = 1.57; % [rad/s]

% decay and cost parameters for obstacle distance
leaderParams.pot_decay = 10;
leaderParams.pot_cost = 15;

% visualization parameters
leaderParams.pos_color = "red";
leaderParams.pred_color = "magenta";
leaderParams.constraint_color = "yellow";
leaderParams.show_predictions = true;
leaderParams.show_constraints = true;
leaderParams.keep_predictions = false;

th = 0:0.2:2*pi;
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

% leader safety shape
leaderParams.dims = [max(leaderParams.initRobotShape(1, :)), max(leaderParams.initRobotShape(2, :))];
[leaderParams.max_axis, leaderParams.axis] = max(leaderParams.dims);
if leaderParams.dims(1) == leaderParams.dims(2) % square robot
    leaderParams.safe_shape = [leaderParams.max_radius * cos(th); leaderParams.max_radius * sin(th)];
    leaderParams.shape = "circle";
elseif leaderParams.axis == 1 % shape is longer in x
    leaderParams.a = leaderParams.max_axis*(1 + 0.2);
    leaderParams.b = sqrt(leaderParams.a^2 * leaderParams.initRobotShape(2,1)^2 / (leaderParams.a^2 - leaderParams.initRobotShape(1,1)^2));
    leaderParams.a = leaderParams.a * 1.1;
    leaderParams.b = leaderParams.b * 1.1;
    leaderParams.safe_shape = [leaderParams.a * cos(th); leaderParams.b * sin(th)];
    leaderParams.shape = "ellipse";
else % shape is longer in y
    leaderParams.b = leaderParams.max_axis*(1 + 0.2);
    leaderParams.a = sqrt(leaderParams.b^2 * leaderParams.initRobotShape(1,1)^2 / (leaderParams.b^2 - leaderParams.initRobotShape(2,1)^2));
    leaderParams.a = leaderParams.a * 1.1;
    leaderParams.b = leaderParams.b * 1.1;
    leaderParams.safe_shape = [leaderParams.a * cos(th); leaderParams.b * sin(th)];
    leaderParams.shape = "ellipse";
end

% FOLLOWER PARAMETERS
% relative distance from leader to follower to have (between the center of
% mass of the robots)
followerParams.d_FL = 1;

% relative cost for distance errors
followerParams.C = 5000; 

% limit on follower acceleration, to be higher than leader
followerParams.u_lim = 5; % [m/s^2]
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

% visualization parameters
followerParams.pos_color = "blue";
followerParams.pred_color = "cyan";
followerParams.constraint_color = "green";
followerParams.show_predictions = true;
followerParams.show_constraints = true;
followerParams.keep_predictions = false;

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

% follower safety shape
followerParams.dims = [max(followerParams.initRobotShape(1, :)), max(followerParams.initRobotShape(2, :))];
[followerParams.max_axis, followerParams.axis] = max(followerParams.dims);
if followerParams.dims(1) == followerParams.dims(2) % square robot
    followerParams.safe_shape = [followerParams.max_radius * cos(th); followerParams.max_radius * sin(th)];
elseif followerParams.axis == 1 % shape is longer in x
    followerParams.a = followerParams.max_axis*(1 + 0.2);
    followerParams.b = sqrt(followerParams.a^2 * followerParams.initRobotShape(2,1)^2 / (followerParams.a^2 - followerParams.initRobotShape(1,1)^2));
    followerParams.a = followerParams.a * 1.1;
    followerParams.b = followerParams.b * 1.1;
    followerParams.safe_shape = [followerParams.a * cos(th); followerParams.b * sin(th)];
else % shape is longer in y
    followerParams.b = followerParams.max_axis*(1 + 0.2);
    followerParams.a = sqrt(followerParams.b^2 * followerParams.initRobotShape(1,1)^2 / (followerParams.b^2 - followerParams.initRobotShape(2,1)^2));
    followerParams.a = followerParams.a * 1.1;
    followerParams.b = followerParams.b * 1.1;
    followerParams.safe_shape = [followerParams.a * cos(th); followerParams.b * sin(th)];
end

% continuous-time system
plantc = ss(Ac,Bc,Cc,Dc);
% discrete-time system
plant = c2d(plantc, Ts, 'zoh'); % exact discretization
[A, B, C, D] = ssdata(plant);
A = Simulink.Parameter(A);
B = Simulink.Parameter(B);
C = Simulink.Parameter(C);
D = Simulink.Parameter(D);

env_name = "two_obs";
[x0, obstacles_0] = setupEnvironment(env_name);
[~, M] = size(obstacles_0);
obstacles_center_0 = zeros(2, M);
obstacles_radius_0 = zeros(2, M);
obstacles_vel_0 = zeros(2, M);
for i = 1:M
    obstacles_center_0(:,i) = obstacles_0{i}.center(:);
    obstacles_radius_0(i) = obstacles_0{i}.radius;
    obstacles_vel_0(:,i) = obstacles_0{i}.velocity(:);
end
x_l_0 = x0;
x_f_0 = x0 + [1; 0; 0; 0; 0; 0]; % at initial condition we have horizontal disposition with d_FL distance

leaderParams.robotShape = Rmat(x_l_0(3))*leaderParams.initRobotShape;
followerParams.robotShape(:, 1:followerParams.vertexes) = Rmat(x_f_0(3))*followerParams.initRobotShape(:, 1:followerParams.vertexes);

% get the instantaneous rotation of load and apply to load and leader
loadTheta_0 = 0; % on the initial step we assume no error in agent position
followerParams.loadShape = Rmat(loadTheta_0)*followerParams.initLoadShape;

sim("simulink_model_sim.slx");