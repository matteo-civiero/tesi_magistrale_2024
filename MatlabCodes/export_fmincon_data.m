% function that create the tables and exports them in excel
% fmincon algorithm comparison

clear all;
close all;

gen_path = "/home/matteociviero/tesi/sims_alg_fmincon_opt/";
alg_fmincon_string = {"interior_point", "sqp", "active_set"};
sims_string = {"fixed_5_no_obs", "fixed_5_two_obs", "fixed_5_three_obs", "fixed_5_valzer", "adaptive_15_5_no_obs", "adaptive_15_5_two_obs", ...
    "adaptive_15_5_three_obs", "adaptive_15_5_valzer"};

%%

for export_f_index = 1:8
    clearvars -except gen_path alg_fmincon_string sims_string export_f_index
    close all
    
    max_formation_error = zeros(3, 1);
    mean_formation_error = zeros(3, 1);
    tot_time_execution = zeros(3, 1);
    max_execution_step_time = zeros(3, 1);
    min_execution_step_time = zeros(3, 1);
    mean_execution_step_time = zeros(3, 1);
    mean_time_long_hor_no_oa = zeros(3, 1);
    mean_time_short_hor_oa = zeros(3, 1);
    ended = zeros(3, 1);
    min_obs_distance = zeros(3, 1);

    for alg_index = 1:3
        load(append(gen_path, sims_string{export_f_index}, "/", alg_fmincon_string{alg_index}, "/data.mat"));
    
        max_formation_error(alg_index) = max_form_err;
        mean_formation_error(alg_index) = mean_form_err;
        tot_time_execution(alg_index) = tot_ex_time;
        max_execution_step_time(alg_index) = max_time_exe;
        min_execution_step_time(alg_index) = min_time_exe;
        mean_execution_step_time(alg_index) = mean_tot_time;
        if fixed_horizon
            mean_time_long_hor_no_oa(alg_index) = NaN;
            mean_time_short_hor_oa(alg_index) = NaN;
        else
            mean_time_long_hor_no_oa(alg_index) = mean0;
            mean_time_short_hor_oa(alg_index) = mean1;
        end
        ended(alg_index) = goal_reached;
        if M >= 1
            min_obs_distance(alg_index) = min_obs_dist;
        else 
            min_obs_distance(alg_index) = NaN;
        end

        clearvars -except gen_path alg_fmincon_string sims_string alg_index export_f_index ...
            max_execution_step_time min_execution_step_time mean_time_short_hor_oa ...
            mean_time_long_hor_no_oa mean_execution_step_time tot_time_execution ...
            max_formation_error mean_formation_error ended min_obs_distance
        close all
    end

    T = table(repmat(sims_string{export_f_index}, 3, 1), reshape(alg_fmincon_string, [3 1]), ended, max_execution_step_time, min_execution_step_time, mean_execution_step_time, ...
        mean_time_long_hor_no_oa, mean_time_short_hor_oa, max_formation_error, mean_formation_error, tot_time_execution, min_obs_distance);

    writetable(T, "/home/matteociviero/tesi/sims_data_fmincon_opt.xlsx", "Sheet", export_f_index);
end