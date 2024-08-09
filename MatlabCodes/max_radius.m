function [max] = max_radius(vertex, n_vert)
%MAX_RADIUS Computes the max radius of the agent's shape

max = 0;
for i = 1:n_vert
    if norm(vertex(:, i)) > max 
        max = norm(vertex(:, i));
    end
end

