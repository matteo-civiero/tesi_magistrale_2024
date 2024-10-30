clear all;
close all;

path_1 = "/home/matteociviero/tesi/cite_1_files/";
path_2 = "/home/matteociviero/tesi/sims_w_perc_range_sqp/";
cases_new = {"fixed_20_no_obs_no_plot/", "fixed_20_two_obs_no_plot/", "fixed_20_three_obs_no_plot/", "fixed_20_valzer_no_plot/", ...
    "adaptive_15_5_no_obs_no_plot/", "adaptive_15_5_two_obs_no_plot/", "adaptive_15_5_three_obs_no_plot/", "adaptive_15_5_valzer_no_plot/"};
env_old = {"no_obs/", "two_obs/", "three_obs/", "valzer/"};

max_formation_error = zeros(12, 1);
mean_formation_error = zeros(12, 1);

for save_index = 1:4
    load(append(path_1, env_old{save_index}, "data.mat"));

    name_array(save_index) = append("cite_1_", env_old{save_index});
    max_formation_error(save_index) = max_form_err;
    mean_formation_error(save_index) = mean_form_err;

    clearvars -except path_2 path_1 cases_new env_old name_array max_formation_error mean_formation_error save_index
    close all;
end

for save_index = 5:12
    load(append(path_2, cases_new{save_index-4}, "data.mat"));

    name_array(save_index) = cases_new{save_index-4};
    max_formation_error(save_index) = max_form_err;
    mean_formation_error(save_index) = mean_form_err;

    clearvars -except path_2 path_1 cases_new env_old name_array max_formation_error mean_formation_error save_index
    close all;
end

%%
Table = table(name_array', max_formation_error, mean_formation_error);
writetable(Table, "/home/matteociviero/tesi/comparison.xlsx");
