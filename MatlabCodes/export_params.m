% script to export parametric analisys data

clear all;
close all;

gen_path = "/home/matteociviero/tesi/params_sims/pot_field/";
specific_path = {"no_obs/", "one_obs/", "corridor/", "obs_near_goal/"}';
env_name_set = {"no_obs", "pathological", "corridor", "obs_near_goal"};
n_params = 5;

for env_index = 2:4
    clearvars -except gen_path specific_path env_index env_name_set n_params
    close all
    
    max_formation_error = zeros(n_params, 1);
    mean_formation_error = zeros(n_params, 1);
    min_ag_obs_dist = zeros(n_params, 1);
    tot_time_execution = zeros(n_params, 1);
    ended = zeros(n_params, 1);

    for n_par = 1:n_params
        load(append(gen_path, specific_path{env_index}, "/", num2str(n_par), "/data.mat"));
    
        max_formation_error(n_par) = max_form_err;
        mean_formation_error(n_par) = mean_form_err;
        tot_time_execution(n_par) = tot_ex_time;
        if M >= 1
            min_ag_obs_dist(n_par) = min_obs_dist;
        else
            min_ag_obs_dist(n_par) = NaN;
        end
        ended(n_par) = goal_reached;

        clearvars -except gen_path specific_path env_name_set env_index max_formation_error mean_formation_error min_ag_obs_dist ...
            tot_time_execution ended n_par n_params
        close all
    end

    T = table(repmat(specific_path{env_index}, n_params, 1), ended, ...
        max_formation_error, mean_formation_error, tot_time_execution, min_ag_obs_dist);

    writetable(T, "/home/matteociviero/tesi/params_sims/pot_field/data.xlsx", "Sheet", env_index);
end