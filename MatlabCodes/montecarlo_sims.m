% simulation file for montecarlo analysis

clear all;
close all;

gen_path = "/home/matteociviero/tesi/mc_sims/";
specific_path = {"adaptive_15_5_no_obs_no_plot/", "adaptive_15_5_two_obs_no_plot/", ...
    "adaptive_15_5_three_obs_no_plot/", "adaptive_15_5_valzer_no_plot/"}';
env_name_set = {"no_obs", "two_obs", "three_obs", "valzer"};

plotting = false;
alg_fmincon = 'sqp';
sim_perception_range = true;
sim_noise = true;
fixed_horizon = false;
N_short = 5;
N_long = 15;
N_sims = 50;

for mc_index = 1:N_sims
    for env_index = 1:4
        clearvars -except gen_path specific_path alg_fmincon plotting mc_index sim_perception_range sim_noise fixed_horizon N_long N_short N_sims ...
            env_name_set env_index
        close all;
    
        env_name = env_name_set{env_index};
        savepath = append(gen_path, specific_path{env_index});

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
end