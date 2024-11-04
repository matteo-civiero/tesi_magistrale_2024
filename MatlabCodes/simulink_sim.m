clear all;
close all;

n = 6;
m = 3;
Ts = 0.1; % sample time
A = [zeros(3,3), eye(3);
     zeros(3,3), zeros(3,3)]; % state matrix
B = [zeros(3,3); eye(3)];
C = eye(n);
D = zeros([n, m]);

% continuous-time system
plantc = ss(A,B,C,D);
% discrete-time system
plant = c2d(plantc, Ts, 'zoh'); % exact discretization

env_name = "two_obs";
[x0, obstacles_0] = setupEnvironment(env_name);
[~, M] = size(obstacles_0);
x_l_0 = x0;
x_f_0 = x0 + [1; 0; 0; 0; 0; 0]; % at initial condition we have horizontal disposition with d_FL distance

sim("simulink_model_sim.slx");