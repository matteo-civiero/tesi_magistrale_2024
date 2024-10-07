function [noise] = meas_noise(sigma_2, sim_noise)
%MEAS_NOISE function that computes a normal noise with covariance sigma_2
%if sim_noise =1
% noise only for x and y coordinates
    if sim_noise
        mu = 0; % mean noise
        R = chol(sigma_2);
        noise_p = [mu + randn*R;
            mu + randn*R];
        noise = [noise_p;
            zeros(4,1)]; % noise
    else
        noise = 0;
    end
end

