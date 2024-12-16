**SIMULINK_GAZEBO** simulink_sim.m is the configuration file to set parameters for the Simulink simulation. simulink_model_sim.slx is the Simulink scheme used for simulations in Gazebo.
To execute the MPC a Level 2 MATLAB S function is used, so MPC_s_function.m represents the S function.

Collision is detected with a custom collision gazebo plugin.

in gazebo_world there are all Gazebo worlds with models used to run simulations. 
