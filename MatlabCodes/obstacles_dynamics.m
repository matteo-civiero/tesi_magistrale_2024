function [obstacles] = obstacles_dynamics(obstacles, Ts, i)
%OBSTACLES_DYNAMICS function that moves the obstacles every iteration of
%the MPC algorithm
%   Every obstacle with a non-null velocity is moved in the correct
%   location after every iteration
for j = 1:length(obstacles)
    obstacles{j}.dynamics(:, i) = obstacles{j}.center;
    obstacles{j}.center = obstacles{j}.center + (obstacles{j}.velocity * Ts);
end

