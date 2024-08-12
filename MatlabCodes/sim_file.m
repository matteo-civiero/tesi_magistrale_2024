% files for playng sim and save data

clear all;
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;
plotting = true;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "no_obs";

% figure names
savepath = "/home/matteociviero/tesi/sims/fixed_20_no_obs_plot/";

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));