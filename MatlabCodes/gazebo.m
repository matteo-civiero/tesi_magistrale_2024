warning('off');
clear all;
close all;

%% SIMULATION PARAMETERS

alg_fmincon = 'sqp';
fixed_horizon = false;
sim_perception_range = true;
sim_noise = false;
sigma_2 = (0.15/3)^2;
eps_loose_grip = 0.1;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "three_obs";

%% CONSTANT PARAMETERS
% constinuous system parameters
leader_mass = 1;
follower_mass = 1;
leader_inertia = 0.166667;
follower_inertia = 0.015;
n = 6;
m = 3;
A = [zeros(3,3), eye(3);
     zeros(3,3), zeros(3,3)]; % state matrix
B = [zeros(3,3); eye(3)];
C = eye(n);
D = zeros([n, m]);

% continuous-time system
plantc = ss(A,B,C,D);
% discrete-time system
Ts = 0.1; % sample time
plant = c2d(plantc, Ts, 'zoh'); % exact discretization

% initial state/position
x0 = [10; 14; 0; 0; 0; 0];

% proximity parameter to the goal position
delta = 0.1;

% COMMON PARAMETERS 
% weight for intermediate states
Q_weight = diag([1, 1, 10, 1, 1, 10]); 
% weight for inputs
R_weight = diag([0.9, 0.9, 0.9]); 
% weight for last state only
P_weight = diag([500, 500, 100, 100, 100, 100]);

% predictive horizon
if fixed_horizon
    N = N_fixed;
else
    N = N_long;
end

P = [1 0 0 0 0 0; 0 1 0 0 0 0]; % selects x and y

% Policy params
policy_halt = true;
k_loose_grip = 3;   % recovery policy horizon
% eps_loose_grip = 0.01; % formation error that triggers recovery policy

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
followerParams.u_lim = 5; % [m/s^2] !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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

% perception range of the system, measured from load center
perception_range_c = 4;
perception_range = perception_range_c * (followerParams.d_FL/2 + max(leaderParams.max_radius, followerParams.max_radius));


% type of environment for papers
[x0, obstacles] = setupEnvironment(env_name);
[~, M] = size(obstacles);
% can be overridden, eventually set value for x0, and cell array obstacles


% precompiled follower elements
% THESE MATRIXES DEPEND ON THE VALUE OF N, IN ADAPTIVE ALGORITHM CAN CHANGE
% EVERY ITERATION, THEY NEED TO BE COMPUTED EVERY TIME
% NOW IN precomp_fixed_step TO BE EXECUTED WHEN FIXED_HORIZON
% followerParams.precompiledElements.Sd_bar = getSdbar(plant.A, plant.B, N);
% followerParams.precompiledElements.Td_bar = getTdbar(plant.A, N);
% followerParams.precompiledElements.S_bar = getSbar(plant.A, plant.B, N);
% followerParams.precompiledElements.T_bar = getTbar(plant.A, N);
% followerParams.precompiledElements.H1 = ...
%     followerParams.precompiledElements.S_bar'*followerParams.precompiledElements.S_bar;
% followerParams.precompiledElements.beta_vec = followerParams.beta .^ (0:(N-1))';
% followerParams.precompiledElements.N = N;

followerParams.precompiledElements.d = followerParams.d_FL;
followerParams.precompiledElements.C = followerParams.C;
followerParams.precompiledElements.L = followerParams.L;
followerParams.precompiledElements.M = length(obstacles);
followerParams.precompiledElements.beta = followerParams.beta;
followerParams.precompiledElements.P = P;
% followerParams.precompiledElements.P_bar = kron(eye(N), followerParams.precompiledElements.P);

leaderParams.precompiledElements.P = P;
% leaderParams.precompiledElements.P_bar = kron(eye(N), followerParams.precompiledElements.P);
% leaderParams.precompiledElements.Sd_bar = followerParams.precompiledElements.Sd_bar;
% leaderParams.precompiledElements.Td_bar = followerParams.precompiledElements.Td_bar;
% leaderParams.precompiledElements.S_bar = followerParams.precompiledElements.S_bar;
% leaderParams.precompiledElements.T_bar = followerParams.precompiledElements.T_bar;

% variable meaning
% x_l, x_f = actual states of leader, follower
% X_L, X_L_stacked = preferred path by leader, 4xN and 4*Nx1 the stacked
% real_d = actual distance between robots

% goal state flag 
goal_reached = false;
i = 1;

%% ROS2

leader_state_node = ros2node('/leader_state');
follower_state_node = ros2node('/follower_state');
leader_input_node = ros2node('/leader_input');
follower_input_node = ros2node('/follower_input');

leader_state = ros2subscriber(leader_state_node, "/leader_odom/leader_odom", "nav_msgs/Odometry");
follower_state = ros2subscriber(follower_state_node, "/follower_odom/follower_odom", "nav_msgs/Odometry");
leader_input = ros2publisher(leader_input_node, "/leader_cf/gazebo_ros_force", "geometry_msgs/Wrench");
follower_input = ros2publisher(follower_input_node, "/follower_cf/gazebo_ros_force", "geometry_msgs/Wrench");

% leader_msg = receive(leader_state, 5);
% follower_msg = receive(follower_state, 5);
% 
% x_l(:, i) = convert_msg_to_state(leader_msg);
% x_f(:, i) = convert_msg_to_state(follower_msg);

% initialization leader and follower STATES
% x_l(:,i) = x0;
% x_f(:,i) = x0 + [followerParams.d_FL; 0; 0; 0; 0; 0]; % at initial condition we have horizontal disposition with d_FL distance

% initialize robot distance, no error assumed on first step
real_d(i) = followerParams.d_FL;

% initial guesses for optimal inputs
U_l_old = zeros([m*N,1]);
U_f_old = zeros([m*N,1]);

% initialize obstacles
if not(sim_perception_range)
    obs_in_perception = obstacles;
end

counter = 0;

% figure; 
% set(gcf,'Visible','on'); hold on; grid on;
% sp = SystemPlotter(leaderParams, followerParams, x_l(:,1), x_f(:, 1), N, obstacles);
% % sp = SystemPlotter(leaderParams, followerParams, x_l(:,1), [], N, obstacles);
% %tit = title("\textbf{Iteration 1, time: 0s}","Interpreter","latex", "FontSize", 14);
% % set(gca, 'XTick', [], 'YTick', []);
% set(gca, "FontSize", 20);
% xlabel("Coordinate x [m]","Interpreter","latex", "FontSize", 40)
% ylabel("Coordinate y [m]","Interpreter","latex", "FontSize", 40)
% xlim([0, 22]);
% ylim([0, 16]);
% xlim([0, 45]);
% ylim([0, 25]);

% initialization of fixed horizon
if fixed_horizon
    % N_fixed given by sim_file
    N = N_fixed;
    U_l_old = zeros([m*N,1]);
    U_f_old = zeros([m*N,1]);
    precomp_fixed_step;
end
 %% MPC
while true 
    tic

    % receiving agents state measure from gazebo
    leader_msg = receive(leader_state, 5);
    follower_msg = receive(follower_state, 5);
    
    x_l(:, i) = convert_msg_to_state(leader_msg);
    x_f(:, i) = convert_msg_to_state(follower_msg);

    % vertexes change orientation because of phi
    % apply rotation for both robots using the orientation
    leaderParams.robotShape = Rmat(x_l(3,i))*leaderParams.initRobotShape;
    followerParams.robotShape(:, 1:followerParams.vertexes) = Rmat(x_f(3,i))*followerParams.initRobotShape(:, 1:followerParams.vertexes);
    
    % get the instantaneous rotation of load and apply to load and leader
    fl_diff = x_f(:, i) - x_l(:, i);
    loadTheta(i) = atan2(fl_diff(2), fl_diff(1));
    followerParams.loadShape = Rmat(loadTheta(i))*followerParams.initLoadShape;

    % obstacles perception
    if sim_perception_range
        obs_in_perception = [];
        cnt = 1;
        for perc_index = 1:length(obstacles)
            if (norm(obstacles{perc_index}.center(:) - (x_f(1:2,i) + Rmat(loadTheta(i)) * followerParams.loadCenter)) - obstacles{perc_index}.radius) < perception_range
                obs_in_perception{cnt} = obstacles{perc_index}; % scanning obstacles sensed
                cnt = cnt + 1;
            end
        end
    end

    % getting q for each agent
    [qi_leader, d_leader] = getObstacleInfo(obs_in_perception, x_l(1:2, i));
    [~, M_leader(i)] = size(qi_leader);

    [qi_follower, d_follower] = getObstacleInfo(obs_in_perception, x_f(1:2, i));
    [~, M_follower(i)] = size(qi_follower);

    [q_load, ~] = getObstacleInfo(obs_in_perception, x_f(1:2, i) + Rmat(loadTheta(i)) * followerParams.loadCenter); % loadCenter rotates with load

    if fixed_horizon % fixed horizon always considers obstacles, so crit_dist = true always
        crit_dist = true;
    else
        % calculations of distances between obstacles for leader and follower
        d_l_min = min(d_leader);
        d_f_min = min(d_follower);
        
        % N_short and N_long given by sim_file
        
        % selection of the state of the algorithm
        if (M_leader(i) == 0) && (M_follower(i) == 0) % no obstacles
             crit_dist = false;
             N = N_long;
        elseif (d_l_min <= leaderParams.rep_dist) || (d_f_min <= followerParams.rep_dist)
            % agents near obstacles, enables obstacle avoidance, need to reduce
            % prediction horizon to be faster
            crit_dist = true;
            if N == N_long % pred horizon changed, need to adapt U_*_old
                N = N_short;
                % fixing the dimension of U_old to enable fmincon
                U_l_old = U_l_old(1:m*N);
                U_f_old = U_f_old(1:m*N);
            else
                N = N_short;
            end
        else 
            % agents far from obstacles, no need to provide for obstacle
            % avoidance, big prediction horizon 
            crit_dist = false;
            if N == N_short % pred horizon changed, need to adapt U_*_old
                N = N_long;
                % fixing the dimension of U_old to enable fmincon
                for s = (N_short + 1):N_long
                    U_l_old((m*(s-1) + 1):(m*(s-1) + 3)) = U_l_old((m*(N_short-1) + 1):(m*(N_short-1) + 3));
                    U_f_old((m*(s-1) + 1):(m*(s-1) + 3)) = U_f_old((m*(N_short-1) + 1):(m*(N_short-1) + 3));
                end
            else
                N = N_long;
            end
        end
    end

    % obtain the next state, the planned path, the identified qis and solver error for leader
    [x_l(:,i+1), X_L, ~, U_l_old] = leaderMPCandUpdate( ...
        plant, x_l(:, i), n, m, N, M_leader(i), leaderParams, obs_in_perception, qi_leader, U_l_old, crit_dist, fixed_horizon, alg_fmincon);
    
    % stack the planned path to supply to the follower, and have it do mpc
    X_L_stacked = reshape(X_L, [n*N, 1]);
    
    %LINEAR follower constraints:
    [x_f(:,i+1), X_F, ~, U_f_old] = followerMPCandUpdate(...
        plant, X_L_stacked, x_f(:, i), n, m, N, M_follower(i), q_load, followerParams, obs_in_perception, qi_follower, U_f_old, loadTheta(i), crit_dist, fixed_horizon, alg_fmincon);

    if policy_halt 
        % check if trajectory does not loose the load
        formation_error_allt = abs(vecnorm(P*(X_L-X_F))-followerParams.d_FL);
        if any(formation_error_allt(1:k_loose_grip) > eps_loose_grip)
            % obtain the next state, the planned path, the identified qis and solver error for leader
            [x_l(:,i+1), X_L, error, U_l_old] = leaderMPCandUpdateHalt( ...
                plant, x_l(:, i), n, m, N, M_leader(i), leaderParams, obs_in_perception, qi_leader, zeros([m*N,1]), crit_dist, fixed_horizon, alg_fmincon);

            % stack the planned path to supply to the follower, and have it do mpc
            X_L_stacked = reshape(X_L, [n*N, 1]);
            %LINEAR follower constraints:
            [x_f(:,i+1), X_F, ~, U_f_old] = followerMPCandUpdate(...
                plant, X_L_stacked, x_f(:, i), n, m, N, M_follower(i), q_load, followerParams, obs_in_perception, qi_follower, zeros([m*N,1]), loadTheta(i), crit_dist, fixed_horizon, alg_fmincon);
        
            counter = counter + 1; 
        end
    end

    % check if goal was reached up to desired precision -> WITH NOISE
    if norm(x_l(1:2,i)) < delta
        goal_reached = true;
    end
    
    % distance between the 2 robots -> WITH NOISE
    real_d(i) = norm(x_l(1:2,i) - x_f(1:2,i));  

    %Obstacle dynamics 
    obstacles = obstacles_dynamics(obstacles, Ts, i);

    % update iteration
    i = i+1;

    % transforming acceleration input in force input
    % sending force inputs to gazebo
    f_l = ros2message("geometry_msgs/Wrench");
    f_l.force.x = U_l_old(1)*leader_mass;
    f_l.force.y = U_l_old(2)*leader_mass;
    f_l.force.z = 0;
    f_l.torque.x = 0;
    f_l.torque.y = 0;
    f_l.torque.z = U_l_old(3)*leader_inertia;

    f_f = ros2message("geometry_msgs/Wrench");
    f_f.force.x = U_f_old(1)*follower_mass;
    f_f.force.y = U_f_old(2)*follower_mass;
    f_f.force.z = 0;
    f_f.torque.x = 0;
    f_f.torque.y = 0;
    f_f.torque.z = U_f_old(3)*follower_inertia;
    
    while toc < 0.1
    end
    
    % sending forces
    send(leader_input, f_l);
    send(follower_input, f_f);
    
end

%% END
clear leader_state follower_state leader_input follower_input
