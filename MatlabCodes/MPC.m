function [u_l, u_f, collision_l, collision_f, collision_load, N, U_l_old, U_f_old] = MPC(x_l, x_f, loadTheta, sim_perception_range, fixed_horizon, alg_fmincon, obstacles, N, N_long, N_short, U_l_old, ...
    U_f_old, n, m, leaderParams, followerParams, plant, P, eps_loose_grip, k_loose_grip, perception_range, policy_halt)
%MPC Summary of this function goes here
%   Detailed explanation goes here
% obstacles perception

if sim_perception_range
    obs_in_perception = [];
    cnt = 1;
    for perc_index = 1:length(obstacles)
        if (norm(obstacles{perc_index}.center(:) - (x_f(1:2) + Rmat(loadTheta) * followerParams.loadCenter)) - obstacles{perc_index}.radius) < perception_range
            obs_in_perception{cnt} = obstacles{perc_index}; % scanning obstacles sensed
            cnt = cnt + 1;
        end
    end
else
    obs_in_perception = obstacles;
end

% getting q for each agent
[qi_leader, d_leader] = getObstacleInfo(obs_in_perception, x_l(1:2));
[~, M_leader] = size(qi_leader);

[qi_follower, d_follower] = getObstacleInfo(obs_in_perception, x_f(1:2));
[~, M_follower] = size(qi_follower);

[q_load, ~] = getObstacleInfo(obs_in_perception, x_f(1:2) + Rmat(loadTheta) * followerParams.loadCenter); % loadCenter rotates with load

% collision detection on current state
[collision_l, collision_f, collision_load] = collision_detection(x_l, x_f, loadTheta, leaderParams, followerParams, M_leader, M_follower, obs_in_perception);


if fixed_horizon % fixed horizon always considers obstacles, so crit_dist = true always
    crit_dist = true;
else
    % calculations of distances between obstacles for leader and follower
    d_l_min = min(d_leader);
    d_f_min = min(d_follower);
    
    % N_short and N_long given by sim_file
    
    % selection of the state of the algorithm
    if (M_leader == 0) && (M_follower == 0) % no obstacles
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
[~, X_L, ~, U_l_old] = leaderMPCandUpdate( ...
    plant, x_l(:), n, m, N, M_leader, leaderParams, obs_in_perception, qi_leader, U_l_old, crit_dist, fixed_horizon, alg_fmincon);

% stack the planned path to supply to the follower, and have it do mpc
X_L_stacked = reshape(X_L, [n*N, 1]);

%LINEAR follower constraints:
[~, X_F, ~, U_f_old] = followerMPCandUpdate(...
    plant, X_L_stacked, x_f(:), n, m, N, M_follower, q_load, followerParams, obs_in_perception, qi_follower, U_f_old, loadTheta, crit_dist, fixed_horizon, alg_fmincon);

if policy_halt 
    % check if trajectory does not loose the load
    formation_error_allt = abs(vecnorm(P*(X_L-X_F))-followerParams.d_FL);
    if any(formation_error_allt(1:k_loose_grip) > eps_loose_grip)
        % obtain the next state, the planned path, the identified qis and solver error for leader
        [~, X_L, error, U_l_old] = leaderMPCandUpdateHalt( ...
            plant, x_l(:), n, m, N, M_leader, leaderParams, obs_in_perception, qi_leader, zeros([m*N,1]), crit_dist, fixed_horizon, alg_fmincon);

        % stack the planned path to supply to the follower, and have it do mpc
        X_L_stacked = reshape(X_L, [n*N, 1]);
        %LINEAR follower constraints:
        [~, X_F, ~, U_f_old] = followerMPCandUpdate(...
            plant, X_L_stacked, x_f(:), n, m, N, M_follower, q_load, followerParams, obs_in_perception, qi_follower, zeros([m*N,1]), loadTheta, crit_dist, fixed_horizon, alg_fmincon);
    end
end

u_l = U_l_old(1:3);
u_f = U_f_old(1:3);
end

