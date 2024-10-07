% simulation file for montecarlo analysis

clear all;
close all;

gen_path = "/home/matteociviero/tesi/montecarlo_15_5_eps/";
error_value = {"6cm/", "10cm/", "15cm/"}';
env_name_set = {"no_obs", "two_obs", "three_obs", "valzer"};

plotting = false;
alg_fmincon = 'sqp';
sim_perception_range = true;
sim_noise = true;
sigma_2_set = {(0.06/3)^2, (0.1/3)^2, (0.15/3)^2,};
epsilon_set = {0.06, 0.1, 0.15};
fixed_horizon = false;
N_short = 5;
N_long = 15;
N_sims = 25;

for error_index = 1:length(error_value)
    sigma_2 = sigma_2_set{error_index};
    eps_loose_grip = epsilon_set{error_index};
    for env_index = 1:4
        env_name = env_name_set{env_index};
        for sim_index = 1:N_sims
            clearvars -except gen_path error_value alg_fmincon plotting error_index sim_perception_range sim_noise fixed_horizon N_long N_short N_sims ...
                env_name_set env_name env_index sim_index sigma_2_set sigma_2 eps_loose_grip epsilon_set
            close all;
        
            savepath = append(gen_path, error_value{error_index}, env_name_set{env_index}, "/", num2str(sim_index), "/");
    
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
end