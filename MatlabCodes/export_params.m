clear all;
close all;

gen_path = "/home/matteociviero/tesi/params_sims/Q/";
specific_path = {"no_obs/", "one_obs/", "corridor/"}';
env_name_set = {"no_obs", "pathological", "corridor"};

for env_index = 1:3
    clearvars -except gen_path specific_path env_index env_name_set
    close all
    
    max_formation_error = zeros(3, 1);
    mean_formation_error = zeros(3, 1);
    min_ag_obs_dist = zeros(3, 1);
    tot_time_execution = zeros(3, 1);
    ended = zeros(3, 1);

    for n_par = 1:3
        load(append(gen_path, specific_path{env_index}, "/", num2str(n_par), "/data.mat"));
    
        max_formation_error(n_par) = max_form_err;
        mean_formation_error(n_par) = mean_form_err;
        tot_time_execution(n_par) = tot_ex_time;
        min_ag_obs_dist(n_par) = min_obst_dist;
        ended(n_par) = goal_reached;

        clearvars -except gen_path specific_path env_name_set env_index max_formation_error mean_formation_error min_ag_obs_dist ...
            tot_time_execution ended n_par
        close all
    end

    T = table(repmat(specific_path{env_index}, 3, 1), ended, ...
        max_formation_error, mean_formation_error, tot_time_execution, min_ag_obs_dist);

    writetable(T, "/home/matteociviero/tesi/params_sims/Q/data.xlsx", "Sheet", env_index);
end