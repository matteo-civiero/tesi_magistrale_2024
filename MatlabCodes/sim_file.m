% files for playng sim and save data

%%

clear all;
close all;

gen_path = "/home/matteociviero/tesi/sims/";
specific_path = {"fixed_20_no_obs_no_plot/", "fixed_20_two_obs_no_plot/", "fixed_20_three_obs_no_plot/", "fixed_20_valzer_no_plot/", ...
    "fixed_15_no_obs_no_plot/", "fixed_15_two_obs_no_plot/", "fixed_15_three_obs_no_plot/", "fixed_15_valzer_no_plot/", "fixed_10_no_obs_no_plot/", ...
    "fixed_10_two_obs_no_plot/", "fixed_10_three_obs_no_plot/", "fixed_10_valzer_no_plot/", "fixed_5_no_obs_no_plot/", "fixed_5_two_obs_no_plot/", ...
    "fixed_5_three_obs_no_plot/", "fixed_5_valzer_no_plot/", "adaptive_20_10_no_obs_no_plot/", "adaptive_20_10_two_obs_no_plot/", ...
    "adaptive_20_10_three_obs_no_plot/", "adaptive_20_10_valzer_no_plot/", "adaptive_20_5_no_obs_no_plot/", "adaptive_20_5_two_obs_no_plot/", ...
    "adaptive_20_5_three_obs_no_plot/", "adaptive_20_5_valzer_no_plot/", "adaptive_15_5_no_obs_no_plot/", "adaptive_15_5_two_obs_no_plot/", ...
    "adaptive_15_5_three_obs_no_plot/", "adaptive_15_5_valzer_no_plot/"}';

plotting = false;

%% fixed_20_no_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "no_obs";

% figure names
sim_index = 1;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_20_two_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "two_obs";

% figure names
sim_index = 2;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_20_three_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "three_obs";

% figure names
sim_index = 3;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_20_valzer_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 20;

env_name = "valzer";

% figure names
sim_index = 4;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_15_no_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 15;

env_name = "no_obs";

% figure names
sim_index = 5;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_15_two_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 15;

env_name = "two_obs";

% figure names
sim_index = 6;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_15_three_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 15;

env_name = "three_obs";

% figure names
sim_index = 7;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_15_valzer_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 15;

env_name = "valzer";

% figure names
sim_index = 8;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_10_no_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "no_obs";

% figure names
sim_index = 9;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_10_two_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "two_obs";

% figure names
sim_index = 10;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_10_three_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "three_obs";

% figure names
sim_index = 11;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_10_valzer_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 10;

env_name = "valzer";

% figure names
sim_index = 12;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_5_no_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "no_obs";

% figure names
sim_index = 13;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_5_two_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "two_obs";

% figure names
sim_index = 14;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_5_three_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "three_obs";

% figure names
sim_index = 15;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% fixed_5_valzer_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = true;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "valzer";

% figure names
sim_index = 16;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_10_no_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "no_obs";

% figure names
sim_index = 17;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_10_two_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "two_obs";

% figure names
sim_index = 18;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_10_three_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "three_obs";

% figure names
sim_index = 19;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_10_valzer_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;

N_short = 10;
N_long = 20;
N_fixed = 5;

env_name = "valzer";

% figure names
sim_index = 20;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_5_no_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;

N_short = 5;
N_long = 20;
N_fixed = 5;

env_name = "no_obs";

% figure names
sim_index = 21;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_5_two_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;

N_short = 5;
N_long = 20;
N_fixed = 5;

env_name = "two_obs";

% figure names
sim_index = 22;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_5_three_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;

N_short = 5;
N_long = 20;
N_fixed = 5;

env_name = "three_obs";

% figure names
sim_index = 23;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_20_5_valzer_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;

N_short = 5;
N_long = 20;
N_fixed = 5;

env_name = "valzer";

% figure names
sim_index = 24;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_15_5_no_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "no_obs";

% figure names
sim_index = 25;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_15_5_two_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "two_obs";

% figure names
sim_index = 26;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_15_5_three_obs_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "three_obs";

% figure names
sim_index = 27;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));

%% adaptive_15_5_valzer_no_plot

clearvars -except gen_path specific_path sim_index plotting
close all;

% SELECTION OF THE ALGORITHM

fixed_horizon = false;

N_short = 5;
N_long = 15;
N_fixed = 5;

env_name = "valzer";

% figure names
sim_index = 28;
savepath = append(gen_path, specific_path{sim_index});

traj_fig_name = append(savepath, "trajectory.jpg");
coord_fig_name = append(savepath, "coordinates.jpg");
vel_fig_name = append(savepath, "velocities.jpg");
obj_dist_fig_name = append(savepath, "obstacle_distance.jpg");
times_fig_name = append(savepath, "times.jpg");
obs_fig_name = append(savepath, "obs.jpg");

simCooperativeTransport;

% saving data
save(append(savepath, "data.mat"));