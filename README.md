**PATH_GEN_OFFLINE** simulink_sim.m is the configuration file to set parameters for the Simulink simulation. simulink_model_sim.slx is the Simulink scheme used for simulations.
To execute the MPC a Level 2 MATLAB S function is used, so MPC_s_function.m represents the S function. Moreover a collision detection Level 2 MATLAB S function is added.

circ_traj_follower.slx is a file to test a simple trajectory, that is used for both simulink and Gazebo (in simulink_gazebo branch).

convert_msg_to_state.m, gazebo.m, read_ros2bag_and_plot_gazebo.m are non-working scripts that performs and collect data of simulations in Gazebo. They are then used as a reference to build the Gazebo communicating architecture in Simulink.

taratura_pid.slx and taratura_pid_vel.slx are used to tune PIDs using a fixed trajectory previously generated.
