% script to export monte carlo analisys

clear all;
close all;

gen_path = "/home/matteociviero/tesi/montecarlo_15_5_eps/";
error_value = {"6cm/", "10cm/", "15cm/"}';
env_name_set = {"no_obs", "two_obs", "three_obs", "valzer"};

%%
sheet = 1;
for err_in = 1:length(error_value)
    for env_in = 1:length(env_name_set)
        name_array = zeros(25, 1);
        max_formation_error = zeros(25, 1);
        mean_formation_error = zeros(25, 1);
        tot_time_execution = zeros(25, 1);
        max_execution_step_time = zeros(25, 1);
        min_execution_step_time = zeros(25, 1);
        mean_execution_step_time = zeros(25, 1);
        mean_time_long_hor_no_oa = zeros(25, 1);
        mean_time_short_hor_oa = zeros(25, 1);
        obs_collision = zeros(25, 1);
        ended = zeros(25, 1);
        min_obs_distance = zeros(25, 1);

        for save_index = 1:25

            load(append(gen_path, error_value{err_in}, env_name_set{env_in}, "/", num2str(save_index), "/data.mat"));
    
            max_formation_error(save_index) = max_form_err;
            mean_formation_error(save_index) = mean_form_err;
            tot_time_execution(save_index) = tot_ex_time;
            max_execution_step_time(save_index) = max_time_exe;
            min_execution_step_time(save_index) = min_time_exe;
            mean_execution_step_time(save_index) = mean_tot_time;
            if fixed_horizon
                mean_time_long_hor_no_oa(save_index) = NaN;
                mean_time_short_hor_oa(save_index) = NaN;
            else
                mean_time_long_hor_no_oa(save_index) = mean0;
                mean_time_short_hor_oa(save_index) = mean1;
            end
            ended(save_index) = goal_reached;
            if M >= 1
                min_obs_distance(save_index) = min_obs_dist;
                obs_collision(save_index) = collision;
            else 
                min_obs_distance(save_index) = NaN;
                obs_collision(save_index) = NaN;
            end

            clearvars -except gen_path error_value err_in env_in env_name_set save_index max_formation_error mean_formation_error ...
                tot_time_execution max_execution_step_time min_execution_step_time mean_execution_step_time mean_time_short_hor_oa ...
                mean_time_long_hor_no_oa ended obs_collision min_obs_distance sheet
            close all;
        end
        Table = table(repmat(error_value{err_in}, 25, 1), repmat(env_name_set{env_in}, 25, 1), ended, obs_collision, max_execution_step_time, min_execution_step_time, mean_execution_step_time, mean_time_long_hor_no_oa, ...
            mean_time_short_hor_oa, max_formation_error, mean_formation_error, tot_time_execution, min_obs_distance);
        writetable(Table, "/home/matteociviero/tesi/noise_eps.xlsx", "Sheet", sheet);
        sheet = sheet + 1;
    end 
end