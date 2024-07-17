function [max] = max_radius(vertex, n_vert)
%MAX_RADIUS Summary of this function goes here
%   Detailed explanation goes here
max = 0;
for i = 1:n_vert
    if norm(vertex(:, i)) > max 
        max = norm(vertex(:, i));
    end
end

