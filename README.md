**ANGOLO_ROTAZIONE**
dummy_sim.m is the configuration file where simulation parameters are set. It calls simCooperativeTransport.mlx to execute the program.

comparison.m, montecarlo_sims.m, sim_file.m, sim_file_fmincon_alg.m, sims_params.m, simulations.m are scripts to run simulations with specific parameters or with a specific purpose. export_data.m, export_fmincon_data.m, export_mc.m, export_params.m are scripts to export tables in excell to collect data and make comparisons. 

convert_msg_to_state.m, gazebo_sim.mlx, simulink_model_sim.slx, simulink_sim.m are non-working prototypes that are then correctly implemented in their specific branch (see main README)
