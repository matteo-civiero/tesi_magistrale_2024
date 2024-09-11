% simulation file for parameter analysis

clear all;
close all;

gen_path = "/home/matteociviero/tesi/params_sims/Q/";
specific_path = {"no_obs/", "one_obs/", "corridor/"}';
env_name_set = {"no_obs", "pathological", "corridor"};

plotting = true;
alg_fmincon = 'sqp';
sim_perception_range = true;
sim_noise = false;
sigma_2 = (0.01)^2;
fixed_horizon = true;
N_fixed = 10;

Q_weight_set = {diag([1, 1, 1, 1, 1, 1]), diag([10, 10, 10, 10, 10, 10]), diag([1, 1, 10, 1, 1, 10])};
R_weight_set = {diag([0.9, 0.9, 0.9]), diag([1.5, 1.5, 10]), diag([0.5, 0.5, 1])};
P_weight_set = {diag([500, 500, 1, 1, 1, 1]), diag([1, 1, 1, 1, 1, 1]), diag([100, 100, 100, 100, 100, 100])};

pot_decay_set = {1, 3, 10};
pot_cost_set = {1, 7, 15};

C_set = {5000, 50, 500};
beta_set = {0.95, 1, 0.97};
R_set = {diag([5, 5, 10]), diag([10, 10, 20]), diag([1, 1, 5])};
rep_dist_c_set = {3, 4, 5};

perception_range_c_set = {5, 6, 7};

for env_index = 1:3
    env_name = env_name_set{env_index};
    for p_index = 1:3
        Q_weight = Q_weight_set{p_index};
        R_weight = R_weight_set{1};
        P_weight = P_weight_set{1};
        leaderParams.pot_decay = pot_decay_set{1};
        leaderParams.pot_cost = pot_cost_set{1};
        leaderParams.rep_dist_c = rep_dist_c_set{1};
        followerParams.C = C_set{1};
        followerParams.beta = beta_set{1};
        followerParams.R = R_set{1};
        followerParams.rep_dist_c = rep_dist_c_set{1};
        perception_range_c = perception_range_c_set{1};

        savepath = append(gen_path, specific_path{env_index}, "/", num2str(p_index), "/");
        traj_fig_name = append(savepath, "trajectory.jpg");
        coord_fig_name = append(savepath, "coordinates.jpg");
        vel_fig_name = append(savepath, "velocities.jpg");
        obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
        times_fig_name = append(savepath, "times.jpg");
        obs_fig_name = append(savepath, "obs.jpg");
        
        simCooperativeTransport;
        
        % saving data
        save(append(savepath, "data.mat"));

        clearvars -except gen_path specific_path env_name_set plotting alg_fmincon sim_perception_range sim_noise fixed_horizon ...
            N_fixed Q_weight_set R_weight_set P_weight_set pot_decay_set pot_cost_set rep_dist_c_set ...
            C_set beta_set R_set sigma_2 perception_range_c_set ...
            env_index env_name p_index
        close all;
    end
end