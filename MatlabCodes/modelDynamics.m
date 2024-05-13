function [y, x_k1] = modelDynamics(plant, x_k, u_k)
% MODELDYNAMIC receives as input the system model, the state at time k and
% the input at time k, and give in output the state at time k+1 and the
% output at time k.
% 

x_k1 = plant.A*x_k + plant.B*u_k;
y = plant.C*x_k;
end

