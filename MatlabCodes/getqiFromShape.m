function [q, d] = getqiFromShape(shape, x0)
% GETQIFROMSHAPE is a function that tries to construct the distance and
% position of the line tangent to the shape and perpendicular to x0 (robot pos)
% shape is a structure holding information on the particular shape
% if shape.type = "circle", shape.center, shape.radius must be present
% if " = "ellipse", shape.a, shape.b, shape.center, shape.theta
% if " = "general_poly", shape.vertices as 2-by-l matrix (l number of vertices)
% if " = "wall" (thing which is perpendicular to axes), shape.is_x_wall,
% shape.wall_pos

switch shape.type
    case "circle"
        dist_from_center = norm(x0-shape.center);
        lambda = 1 - shape.radius / dist_from_center;
        d = lambda*dist_from_center;
        q = x0 + (shape.center-x0)*lambda;
        return;
        
    case "wall"
        if shape.is_x_wall % meaning it is along x axis
            q = [x0(1); shape.wall_pos];
        else
            q = [shape.wall_pos; x0(2)];
        end
        d = norm(x0-q);
        return;
        
    case "ellipse"
        % get parames and shift cause calculations are made for an ellipse
        % centered at the origin
        a = shape.a; b = shape.b; theta = shape.theta;
        x0_shift =  x0 - shape.center;
        x0x = x0_shift(1); x0y = x0_shift(2);
        q_phi_shift = @(phi) [a* cos(theta)*cos(phi)-b*sin(theta)*sin(phi); a* sin(theta)*cos(phi)+b*cos(theta)*sin(phi)];
        d1_phi = @(phi) 2*abs(x0x - a*cos(phi)*cos(theta) + b*sin(phi)*sin(theta))*sign(x0x - a*cos(phi)*cos(theta) + b*sin(phi)*sin(theta))*(a*cos(theta)*sin(phi) + b*cos(phi)*sin(theta)) + 2*abs(a*cos(phi)*sin(theta) - x0y + b*cos(theta)*sin(phi))*sign(a*cos(phi)*sin(theta) - x0y + b*cos(theta)*sin(phi))*(b*cos(phi)*cos(theta) - a*sin(phi)*sin(theta));
        d2_phi = @(phi) 2*sign(a*cos(phi)*sin(theta) - x0y + b*cos(theta)*sin(phi))^2*(b*cos(phi)*cos(theta) - a*sin(phi)*sin(theta))^2 + 2*sign(x0x - a*cos(phi)*cos(theta) + b*sin(phi)*sin(theta))^2*(a*cos(theta)*sin(phi) + b*cos(phi)*sin(theta))^2 + 2*abs(x0x - a*cos(phi)*cos(theta) + b*sin(phi)*sin(theta))*sign(x0x - a*cos(phi)*cos(theta) + b*sin(phi)*sin(theta))*(a*cos(phi)*cos(theta) - b*sin(phi)*sin(theta)) + 4*abs(a*cos(phi)*sin(theta) - x0y + b*cos(theta)*sin(phi))*dirac(a*cos(phi)*sin(theta) - x0y + b*cos(theta)*sin(phi))*(b*cos(phi)*cos(theta) - a*sin(phi)*sin(theta))^2 + 4*abs(x0x - a*cos(phi)*cos(theta) + b*sin(phi)*sin(theta))*dirac(x0x - a*cos(phi)*cos(theta) + b*sin(phi)*sin(theta))*(a*cos(theta)*sin(phi) + b*cos(phi)*sin(theta))^2 - 2*abs(a*cos(phi)*sin(theta) - x0y + b*cos(theta)*sin(phi))*sign(a*cos(phi)*sin(theta) - x0y + b*cos(theta)*sin(phi))*(a*cos(phi)*sin(theta) + b*cos(theta)*sin(phi));
        % a good initial guess is the point intersection of ellipse and
        % C->x0 ray
        phi_init = atan2(x0y,x0x) - theta;
        phi_opt = ND(phi_init, d1_phi, d2_phi, 100, 0.005);
        q = q_phi_shift(phi_opt) + shape.center;
        d = norm(x0 - q);
        return;
        
    case "general_poly"
        q = [0; 0];
        d = 0;
        return;
end
end

