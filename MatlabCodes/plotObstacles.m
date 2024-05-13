function p = plotObstacles(obstacles)
%PLOT_ROBOT Summary of this function goes here
%   Detailed explanation goes here obj_pos, obj_radius
[~, obst_n] = size(obstacles);
for i = 1:obst_n
    switch obstacles{i}.type
        case "circle"
            c = obstacles{i}.center;
            r = obstacles{i}.radius;
            p{2*i -1} = plot(c(1), c(2), '+r');         % obstacle centers
            p{2*i} = viscircles(c', r,'LineStyle', '--', 'Color', 'black'); % obstacle safe zone

        case "wall"
            

        case "ellipse"
            

        case "general_poly"
            
    end
end

end