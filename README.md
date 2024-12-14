**A Variable Prediction Horizon MPC Approach for Leader-Follower Transportation in Presence of Obstacles** (Framework)
Branches:
- main: original code of article *"Model Predictive Control for Cooperative Transportation with Feasibility-Aware Policy" Badr Elaamery, Massimo Pesavento, Teresa Aldovini, Nicola Lissandrini, Giulia Michieletto, and Angelo Cenedese*
- originale_corretto: original code with all bugs fixed.
- angolo_rotazione: branch used for MATLAB simulations, such as comparing the performance of fixed and variable prediction horizon, optimal parameters analysis and montecarlo analysis.
- path_gen_offline: branch used for Simulink simulations, where the PID structure implemented contains position-heading angle + velocity PIDs with velocity feedforward.
- path_gen_offline_pos_only: branch used for Simulink simulations, where the PID structure implemented contains position_heading angle PIDs.
- simulink_gazebo: branch that uses the Simulink scheme introduced in path_gen_offline_pos_only to make Gazebo simulations. (results reported in the thesis document)
- simulink_gazebo_contr_vel: branch that uses the Simulink scheme introduced in path_gen_offline to make Gazebo simulations. (just for tests, results not reported)

**MAIN**	
simCooperativeTransport.mlx is the main program that executes the algorithm.
constraints.m, followerMPCandUpdateNC.m and followerNC.m are not actually used in this project.

