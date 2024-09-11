function [y, x_k1] = modelDynamics(plant, x_k, u_k, sigma_2, sim_noise)
% MODELDYNAMIC receives as input the system model, the state at time k and
% the input at time k, and give in output the state at time k+1 and the
% output at time k.
% 

if sim_noise
    mu = 0; % mean noise
    R = chol(sigma_2);
    noise_p = [mu + randn*R;
        mu + randn*R];
    noise = [noise_p;
        zeros(4,1)]; % process noise
else
    noise = 0;
end

x_k1 = plant.A*x_k + plant.B*u_k + noise;
y = plant.C*x_k;
end

