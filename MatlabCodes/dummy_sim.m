clear all;
close all;

plotting = true;
alg_fmincon = 'sqp';
fixed_horizon = false;
sim_perception_range = true;
sim_noise = false;
sigma_2 = (0.01)^2;

N_short = 5;
N_long = 15;
N_fixed = 10;

env_name = "valzer";

traj_fig_name = 0;
coord_fig_name = 0;
vel_fig_name = 0;
obj_dist_fig_name = 0;
times_fig_name = 0;
obs_fig_name = 0;

simCooperativeTransport;