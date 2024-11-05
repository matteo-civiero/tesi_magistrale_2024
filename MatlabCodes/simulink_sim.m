clear all;
close all;

n = 6;
m = 3;
Ts = 0.1; % sample time
Ac = [zeros(3,3), eye(3);
     zeros(3,3), zeros(3,3)]; % state matrix
Bc = [zeros(3,3); eye(3)];
Cc = eye(n);
Dc = zeros([n, m]);
delta = 0.1;

% continuous-time system
plantc = ss(Ac,Bc,Cc,Dc);
% discrete-time system
plant = c2d(plantc, Ts, 'zoh'); % exact discretization
[A, B, C, D] = ssdata(plant);
A = Simulink.Parameter(A);
B = Simulink.Parameter(B);
C = Simulink.Parameter(C);
D = Simulink.Parameter(D);

env_name = "two_obs";
[x0, obstacles_0] = setupEnvironment(env_name);
[~, M] = size(obstacles_0);
obstacles_center_0 = zeros(2, M);
obstacles_radius_0 = zeros(2, M);
obstacles_vel_0 = zeros(2, M);
for i = 1:M
    obstacles_center_0(:,i) = obstacles_0{i}.center(:);
    obstacles_radius_0(i) = obstacles_0{i}.radius;
    obstacles_vel_0(:,i) = obstacles_0{i}.velocity(:);
end
% initialization leader and follower STATES
x_l_0 = x0;
x_f_0 = x0 + [1; 0; 0; 0; 0; 0]; % at initial condition we have horizontal disposition with d_FL distanc