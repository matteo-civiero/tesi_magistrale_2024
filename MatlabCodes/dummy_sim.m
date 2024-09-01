clear all;
close all;

plotting = true;
alg_fmincon = 'sqp';
fixed_horizon = true;
sim_perception_range = true;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "three_obs";

traj_fig_name = 0;
coord_fig_name = 0;
vel_fig_name = 0;
obj_dist_fig_name = 0;
times_fig_name = 0;
obs_fig_name = 0;

simCooperativeTransport;