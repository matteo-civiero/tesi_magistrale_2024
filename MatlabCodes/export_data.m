% FILE TO EXPORT SOME DATA IN CSV

clear all

gen_path = "/home/matteociviero/tesi/sims/";
specific_path = {"fixed_20_no_obs_no_plot", "fixed_20_two_obs_no_plot", "fixed_20_three_obs_no_plot", "fixed_20_valzer_no_plot", ...
    "fixed_15_no_obs_no_plot", "fixed_15_two_obs_no_plot", "fixed_15_three_obs_no_plot", "fixed_15_valzer_no_plot", "fixed_10_no_obs_no_plot", ...
    "fixed_10_two_obs_no_plot", "fixed_10_three_obs_no_plot", "fixed_10_valzer_no_plot", "fixed_5_no_obs_no_plot", "fixed_5_two_obs_no_plot", ...
    "fixed_5_three_obs_no_plot", "fixed_5_valzer_no_plot", "adaptive_20_10_no_obs_no_plot", "adaptive_20_10_two_obs_no_plot", ...
    "adaptive_20_10_three_obs_no_plot", "adaptive_20_10_valzer_no_plot", "adaptive_20_5_no_obs_no_plot", "adaptive_20_5_two_obs_no_plot", ...
    "adaptive_20_5_three_obs_no_plot", "adaptive_20_5_valzer_no_plot", "adaptive_15_5_no_obs_no_plot", "adaptive_15_5_two_obs_no_plot", ...
    "adaptive_15_5_three_obs_no_plot", "adaptive_15_5_valzer_no_plot"}';

%%

name_array = zeros(28, 1);
max_formation_error = zeros(28, 1);
mean_formation_error = zeros(28, 1);
tot_time_execution = zeros(28, 1);
max_execution_step_time = zeros(28, 1);
min_execution_step_time = zeros(28, 1);
mean_execution_step_time = zeros(28, 1);
mean_time_long_hor_no_oa = zeros(28, 1);
mean_time_short_hor_oa = zeros(28, 1);

for save_index = 1:28
    load(append(gen_path, specific_path{save_index}, "/data.mat"));

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

    clearvars -except gen_path specific_path max_execution_step_time min_execution_step_time save_index mean_execution_step_time ...
        mean_time_short_hor_oa mean_time_long_hor_no_oa max_formation_error mean_formation_error tot_time_execution
    close all
end

%% Table 
Table = table(specific_path, max_execution_step_time, min_execution_step_time, mean_execution_step_time, mean_time_long_hor_no_oa, mean_time_short_hor_oa, max_formation_error, mean_formation_error, tot_time_execution);
writetable(Table, "/home/matteociviero/tesi/sims_data.xlsx");