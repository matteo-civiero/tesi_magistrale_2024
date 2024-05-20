function [obstacles] = obstacles_dynamics(obstacles, Ts)
%OBSTACLES_DYNAMICS function that moves the obstacles every iteration of
%the MPC algorithm
%   Every obstacle with a non-null velocity is moved in the correct
%   location after every iteration
for i = 1:length(obstacles)
    obstacles{i}.center = obstacles{i}.center + (obstacles{i}.velocity * Ts);
end

