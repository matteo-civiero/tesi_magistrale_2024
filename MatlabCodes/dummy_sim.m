clear all;
close all;

plotting = false;
alg_fmincon = 'sqp';
fixed_horizon = false;
sim_perception_range = true;
sim_noise = false;
sigma_2 = (0.15/3)^2;
eps_loose_grip = 0.15;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "corridor";

traj_fig_name = "trajectory.jpg";
coord_fig_name = "coordinates.jpg";
vel_fig_name = "velocities.jpg";
obj_dist_fig_name = "obstacle_distance.jpg";
times_fig_name = "times.jpg";
obs_fig_name = "obs.jpg";

simCooperativeTransport;