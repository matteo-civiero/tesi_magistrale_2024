% files for playng sim and save data

%%

gen_path = "/home/matteociviero/tesi/sims/";
specific_path = {"fixed_20_no_obs_no_plot", "fixed_20_two_obs_no_plot", "fixed_20_three_obs_no_plot", "fixed_20_valzer_no_plot", ...
    "fixed_15_no_obs_no_plot", "fixed_15_two_obs_no_plot", "fixed_15_three_obs_no_plot", "fixed_15_valzer_no_plot", "fixed_10_no_obs_no_plot", ...
    "fixed_10_two_obs_no_plot", "fixed_10_three_obs_no_plot", "fixed_10_valzer_no_plot", "fixed_5_no_obs_no_plot", "fixed_5_two_obs_no_plot", ...
    "fixed_5_three_obs_no_plot", "fixed_5_valzer_no_plot", "adaptive_20_10_no_obs_no_plot", "adaptive_20_10_two_obs_no_plot", ...
    "adaptive_20_10_three_obs_no_plot", "adaptive_20_10_valzer_no_plot", "adaptive_20_5_no_obs_no_plot", "adaptive_20_5_two_obs_no_plot", ...
    "adaptive_20_5_three_obs_no_plot", "adaptive_20_5_valzer_no_plot", "adaptive_15_5_no_obs_no_plot", "adaptive_15_5_two_obs_no_plot", ...
    "adaptive_15_5_three_obs_no_plot", "adaptive_15_5_valzer_no_plot"}';
sim_index = 1;

%% fixed_20_no_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "no_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_20_two_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "two_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_20_three_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "three_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_20_valzer_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "valzer";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_15_no_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 15;

env_name = "no_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_15_two_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 15;

env_name = "two_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_15_three_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 15;

env_name = "three_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_15_valzer_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 15;

env_name = "valzer";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_10_no_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "no_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_10_two_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "two_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_10_three_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "three_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_10_valzer_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "valzer";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_5_no_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "no_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_5_two_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "two_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_5_three_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "three_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% fixed_5_valzer_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "valzer";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% adaptive_20_10_no_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "no_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% adaptive_20_10_two_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "two_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% adaptive_20_10_three_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "three_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% adaptive_20_10_valzer_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "valzer";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% adaptive_20_5_no_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 20;
N_fixed = 5;

env_name = "no_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% adaptive_20_5_two_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 20;
N_fixed = 5;

env_name = "two_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% adaptive_20_5_three_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 20;
N_fixed = 5;

env_name = "three_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% adaptive_20_5_valzer_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 20;
N_fixed = 5;

env_name = "valzer";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% adaptive_15_5_no_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "no_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% adaptive_15_5_two_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "two_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% adaptive_15_5_three_obs_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "three_obs";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;

%% adaptive_15_5_valzer_no_plot

clearvars -except gen_path specific_path sim_index
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "valzer";

% figure names
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

sim_index = sim_index + 1;