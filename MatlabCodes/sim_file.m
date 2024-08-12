% files for playng sim and save data

%% fixed_20_no_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "no_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_20_no_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_20_two_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "two_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_20_two_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_20_three_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "three_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_20_three_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_20_valzer_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "valzer";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_20_valzer_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_15_no_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 15;

env_name = "no_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_15_no_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_15_two_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 15;

env_name = "two_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_15_two_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_15_three_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 15;

env_name = "three_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_15_three_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_15_valzer_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 15;

env_name = "valzer";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_15_valzer_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_10_no_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "no_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_10_no_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_10_two_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "two_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_10_two_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_10_three_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "three_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_10_three_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_10_valzer_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "valzer";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_10_valzer_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_5_no_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "no_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_5_no_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_5_two_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "two_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_5_two_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_5_three_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "three_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_5_three_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_5_valzer_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "valzer";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_5_valzer_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_10_no_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "no_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/adaptive_20_10_no_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_10_two_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "two_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/adaptive_20_10_two_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_10_three_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "three_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/adaptive_20_10_three_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_10_valzer_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "valzer";

% figure names
savepath = "/home/matteociviero/tesi/sims/adaptive_20_10_valzer_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_5_no_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 20;
N_fixed = 5;

env_name = "no_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/adaptive_20_5_no_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_5_two_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 20;
N_fixed = 5;

env_name = "two_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/adaptive_20_5_two_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_5_three_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 20;
N_fixed = 5;

env_name = "three_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/adaptive_20_5_three_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_5_valzer_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 20;
N_fixed = 5;

env_name = "valzer";

% figure names
savepath = "/home/matteociviero/tesi/sims/adaptive_20_5_valzer_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_15_5_no_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "no_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/adaptive_15_5_no_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_15_5_two_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "two_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/adaptive_15_5_two_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_15_5_three_obs_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "three_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/adaptive_15_5_three_obs_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_15_5_valzer_no_plot

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;
plotting = false;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "valzer";

% figure names
savepath = "/home/matteociviero/tesi/sims/adaptive_15_5_valzer_no_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));