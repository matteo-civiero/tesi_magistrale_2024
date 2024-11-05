function [q, d] = getqiFromShape(center, radius, x0)
% GETQIFROMSHAPE is a function that tries to construct the distance and
% position of the line tangent to the shape and perpendicular to x0 (robot pos)
% shape is a structure holding information on the particular shape
% if shape.type = "circle", shape.center, shape.radius must be present
% if " = "ellipse", shape.a, shape.b, shape.center, shape.theta
% if " = "general_poly", shape.vertices as 2-by-l matrix (l number of vertices)
% if " = "wall" (thing which is perpendicular to axes), shape.is_x_wall,
% shape.wall_pos
% x0 position of agent

dist_from_center = norm(x0-center);
lambda = 1 - radius / dist_from_center; % 0 if collision, > 0 if safe
d = lambda*dist_from_center; % dist_from_center - radius (distance between agent and surface of obs)
q = x0 + (center-x0)*lambda; % position of the line tangent to the shape and perpendicular to x0

end

