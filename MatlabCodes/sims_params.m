% simulation file for parameter analysis

clear all;
close all;

gen_path = "/home/matteociviero/tesi/params_sims/pot_field/";
specific_path = {"no_obs/", "one_obs/", "corridor/", "obs_near_goal/"}';
env_name_set = {"no_obs", "pathological", "corridor", "obs_near_goal"};

plotting = true;
alg_fmincon = 'sqp';
sim_perception_range = true;
sim_noise = false;
sigma_2 = (0.01)^2;
fixed_horizon = true;
N_fixed = 10;
N_short = 5;
N_long = 15;

Q_weight_set = {diag([1, 1, 1, 1, 1, 1]), diag([10, 10, 10, 10, 10, 10]), diag([1, 1, 10, 1, 1, 10]), diag([1, 1, 10, 1, 1, 10])};
R_weight_set = {diag([0.9, 0.9, 0.9]), diag([1.5, 1.5, 10]), diag([1, 1, 10]), diag([0.9, 0.9, 0.9])};
P_weight_set = {diag([1, 1, 1, 1, 1, 1]), diag([10, 10, 10, 10, 10, 10]), diag([100, 100, 100, 100, 100, 100]), diag([500, 500, 100, 100, 100, 100])};

pot_decay_set = {1, 1, 3, 3, 10};
pot_cost_set = {1, 7, 7, 15, 15};

C_set = {5000, 5000, 500, 50, 5000};
beta_set = {0.95, 1, 0.97, 1, 0.90};

R_set = {diag([5, 5, 10]), diag([10, 10, 20]), diag([1, 1, 5]), diag([1, 1, 1]), diag([0.5, 0.5, 0.5])};
rep_dist_c_set = {2, 3, 4, 5};

perception_range_c_set = {4, 5, 6, 7};

for env_index = 4
    env_name = env_name_set{env_index};

    Q_weight = Q_weight_set{4};
    R_weight = R_weight_set{4};
    P_weight = P_weight_set{4};

    followerParams.R = R_set{4};

    followerParams.C = C_set{1};
    followerParams.beta = beta_set{1};

    leaderParams.rep_dist_c = rep_dist_c_set{2};
    followerParams.rep_dist_c = rep_dist_c_set{2};

    perception_range_c = perception_range_c_set{1};

    for par_index = 3
        leaderParams.pot_decay = pot_decay_set{par_index};
        leaderParams.pot_cost = pot_cost_set{par_index};

        savepath = append(gen_path, specific_path{env_index}, num2str(par_index), "/");
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
            N_fixed N_long N_short Q_weight_set R_weight_set P_weight_set pot_decay_set pot_cost_set rep_dist_c_set ...
            C_set beta_set R_set sigma_2 perception_range_c_set ...
            env_index env_name p_index q_index r_index ...
            leaderParams followerParams perception_range_c Q_weight R_weight P_weight
        close all;

    end
end