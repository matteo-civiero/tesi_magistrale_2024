% Simulation file to see if the algorithm 'active-set' of fmincon is still
% the best choice
% testing on fixed_5 and adaptive_15_5, all environment

clear all;
close all;

gen_path = "/home/matteociviero/tesi/sims_alg_fmincon_opt/";
alg_fmincon_set = {'interior-point', 'sqp', 'active-set'};
alg_fmincon_string = {"interior_point", "sqp", "active_set"};
plotting = false;
sim_perception_range = true;
sim_noise = false;
sigma_2 = (0.1/3)^2;

%% Simulations

for fmincon_index = 1:3

    clearvars -except gen_path alg_fmincon_set alg_fmincon_string plotting fmincon_index sim_perception_range sim_noise sigma_2
    close all;

    % SELECTION OF THE ALGORITHM

    fixed_horizon = true;

    N_short = 10;
    N_long = 20;
    N_fixed = 5;

    env_name = "no_obs";

    alg_fmincon = alg_fmincon_set{fmincon_index};

    % figure names
    savepath = append(gen_path, "fixed_5_no_obs/", alg_fmincon_string{fmincon_index}, "/");

    traj_fig_name = append(savepath, "trajectory.jpg");
    coord_fig_name = append(savepath, "coordinates.jpg");
    vel_fig_name = append(savepath, "velocities.jpg");
    obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
    times_fig_name = append(savepath, "times.jpg");
    obs_fig_name = append(savepath, "obs.jpg");

    simCooperativeTransport;

    % saving data
    save(append(savepath, "data.mat"));


   % -----------------------------------------------------------------------

    clearvars -except gen_path alg_fmincon_set alg_fmincon_string plotting fmincon_index sim_perception_range sim_noise sigma_2
    close all;

    % SELECTION OF THE ALGORITHM

    fixed_horizon = true;

    N_short = 10;
    N_long = 20;
    N_fixed = 5;

    env_name = "two_obs";

    alg_fmincon = alg_fmincon_set{fmincon_index};

    % figure names
    savepath = append(gen_path, "fixed_5_two_obs/", alg_fmincon_string{fmincon_index}, "/");

    traj_fig_name = append(savepath, "trajectory.jpg");
    coord_fig_name = append(savepath, "coordinates.jpg");
    vel_fig_name = append(savepath, "velocities.jpg");
    obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
    times_fig_name = append(savepath, "times.jpg");
    obs_fig_name = append(savepath, "obs.jpg");

    simCooperativeTransport;

    % saving data
    save(append(savepath, "data.mat"));

    % -----------------------------------------------------------------------

    clearvars -except gen_path alg_fmincon_set alg_fmincon_string plotting fmincon_index sim_perception_range sim_noise sigma_2
    close all;

    % SELECTION OF THE ALGORITHM

    fixed_horizon = true;

    N_short = 10;
    N_long = 20;
    N_fixed = 5;

    env_name = "three_obs";

    alg_fmincon = alg_fmincon_set{fmincon_index};

    % figure names
    savepath = append(gen_path, "fixed_5_three_obs/", alg_fmincon_string{fmincon_index}, "/");

    traj_fig_name = append(savepath, "trajectory.jpg");
    coord_fig_name = append(savepath, "coordinates.jpg");
    vel_fig_name = append(savepath, "velocities.jpg");
    obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
    times_fig_name = append(savepath, "times.jpg");
    obs_fig_name = append(savepath, "obs.jpg");

    simCooperativeTransport;

    % saving data
    save(append(savepath, "data.mat"));

    % -----------------------------------------------------------------------

    clearvars -except gen_path alg_fmincon_set alg_fmincon_string plotting fmincon_index sim_perception_range sim_noise sigma_2
    close all;

    % SELECTION OF THE ALGORITHM

    fixed_horizon = true;

    N_short = 10;
    N_long = 20;
    N_fixed = 5;

    env_name = "valzer";

    alg_fmincon = alg_fmincon_set{fmincon_index};

    % figure names
    savepath = append(gen_path, "fixed_5_valzer/", alg_fmincon_string{fmincon_index}, "/");

    traj_fig_name = append(savepath, "trajectory.jpg");
    coord_fig_name = append(savepath, "coordinates.jpg");
    vel_fig_name = append(savepath, "velocities.jpg");
    obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
    times_fig_name = append(savepath, "times.jpg");
    obs_fig_name = append(savepath, "obs.jpg");

    simCooperativeTransport;

    % saving data
    save(append(savepath, "data.mat"));

    % -------------------------------------------------------------------------

    clearvars -except gen_path alg_fmincon_set alg_fmincon_string plotting fmincon_index sim_perception_range sim_noise sigma_2
    close all;

    % SELECTION OF THE ALGORITHM

    fixed_horizon = false;

    N_short = 5;
    N_long = 15;
    N_fixed = 5;

    env_name = "no_obs";

    alg_fmincon = alg_fmincon_set{fmincon_index};

    % figure names
    savepath = append(gen_path, "adaptive_15_5_no_obs/", alg_fmincon_string{fmincon_index}, "/");

    traj_fig_name = append(savepath, "trajectory.jpg");
    coord_fig_name = append(savepath, "coordinates.jpg");
    vel_fig_name = append(savepath, "velocities.jpg");
    obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
    times_fig_name = append(savepath, "times.jpg");
    obs_fig_name = append(savepath, "obs.jpg");

    simCooperativeTransport;

    % saving data
    save(append(savepath, "data.mat"));


   % -----------------------------------------------------------------------

    clearvars -except gen_path alg_fmincon_set alg_fmincon_string plotting fmincon_index sim_perception_range sim_noise sigma_2
    close all;

    % SELECTION OF THE ALGORITHM

    fixed_horizon = false;

    N_short = 5;
    N_long = 15;
    N_fixed = 5;

    env_name = "two_obs";

    alg_fmincon = alg_fmincon_set{fmincon_index};

    % figure names
    savepath = append(gen_path, "adaptive_15_5_two_obs/", alg_fmincon_string{fmincon_index}, "/");

    traj_fig_name = append(savepath, "trajectory.jpg");
    coord_fig_name = append(savepath, "coordinates.jpg");
    vel_fig_name = append(savepath, "velocities.jpg");
    obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
    times_fig_name = append(savepath, "times.jpg");
    obs_fig_name = append(savepath, "obs.jpg");

    simCooperativeTransport;

    % saving data
    save(append(savepath, "data.mat"));

    % -----------------------------------------------------------------------

    clearvars -except gen_path alg_fmincon_set alg_fmincon_string plotting fmincon_index sim_perception_range sim_noise sigma_2
    close all;

    % SELECTION OF THE ALGORITHM

    fixed_horizon = false;

    N_short = 5;
    N_long = 15;
    N_fixed = 5;

    env_name = "three_obs";

    alg_fmincon = alg_fmincon_set{fmincon_index};

    % figure names
    savepath = append(gen_path, "adaptive_15_5_three_obs/", alg_fmincon_string{fmincon_index}, "/");

    traj_fig_name = append(savepath, "trajectory.jpg");
    coord_fig_name = append(savepath, "coordinates.jpg");
    vel_fig_name = append(savepath, "velocities.jpg");
    obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
    times_fig_name = append(savepath, "times.jpg");
    obs_fig_name = append(savepath, "obs.jpg");

    simCooperativeTransport;

    % saving data
    save(append(savepath, "data.mat"));

    % -----------------------------------------------------------------------

    clearvars -except gen_path alg_fmincon_set alg_fmincon_string plotting fmincon_index sim_perception_range sim_noise sigma_2
    close all;

    % SELECTION OF THE ALGORITHM

    fixed_horizon = false;

    N_short = 5;
    N_long = 15;
    N_fixed = 5;

    env_name = "valzer";

    alg_fmincon = alg_fmincon_set{fmincon_index};

    % figure names
    savepath = append(gen_path, "adaptive_15_5_valzer/", alg_fmincon_string{fmincon_index}, "/");

    traj_fig_name = append(savepath, "trajectory.jpg");
    coord_fig_name = append(savepath, "coordinates.jpg");
    vel_fig_name = append(savepath, "velocities.jpg");
    obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
    times_fig_name = append(savepath, "times.jpg");
    obs_fig_name = append(savepath, "obs.jpg");

    simCooperativeTransport;

    % saving data
    save(append(savepath, "data.mat"));
end