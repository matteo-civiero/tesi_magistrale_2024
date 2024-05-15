function [new_obstacles] = obstacles_dynamics(obstacles, Ts)
%OBSTACLES_DYNAMICS function that moves the obstacles every iteration of
%the MPC algorithm
%   Every obstacle with a non-null velocity is moved in the correct
%   location after every iteration
new_obstacles = obstacles; % to copy the informations
for i = 1:length(obstacles)
    new_obstacles{i}.center = obstacles{i}.center + (obstacles{i}.velocity * Ts);
end

