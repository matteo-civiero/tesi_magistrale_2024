function [G,W,S] = rigidBodyConstraints(N, u_max, phi_dot_max, v_max, w_max, n, S_bar, T_bar)
% [G,W,S] = CONSTRAINTS(A,B,x0, q_points, N, u_max, v_max, robotShape)
% Generate constraints for U in optimization of the type G*U <= W + S(x0) based
% on the positions (in q_points) of the minimum distance points from an
% obstacle, considering as infeasible regions over the tangent to the perpendicular x0-> qi. 
% N is the optimization horizon, A and B are the plant discrete matrices,
% u_max is the maximun accepted value for input in all directions. 
% v_max is the maximun accepted value for velocity in all directions. U is the
% vector of stacket inputs at each time. x0 is the STATE of robot.
% robotShape must be a 2-by-L matrix with vectors of relative positions wrt
% leader 

% prepare constraints for input (max accelerations)
% just require that each component of acceleration is such that |u_xy|<amax
G_acc_constr = [1 0 0; -1 0 0; 0 1 0; 0 -1 0; 0 0 1; 0 0 -1]; % multiplicator to u (3 coords, 2 bounds)
G_in = kron(eye(N), G_acc_constr); % this requirement must hold for all times
B_in = repmat([u_max; u_max; u_max; u_max; phi_dot_max; phi_dot_max], N, 1); % repeat vertically as the bound affects each time

% prepare constraints for velocity
% just require that each component of velocity is such that |v_xy|<vmax
A_vel_constr = [0, 0, 0, 1, 0, 0;
                0, 0, 0, -1, 0, 0;
                0, 0, 0, 0, 1, 0;
                0, 0, 0, 0, -1, 0;
                0, 0, 0, 0, 0, 1;
                0, 0, 0, 0, 0, -1;];% multiplicator to x (3 coords, 2 bounds)
A_vel = kron(eye(N), A_vel_constr);
B_vel_constr = repmat( [v_max; v_max; v_max; v_max; w_max; w_max] , N, 1);

G = [G_in; A_vel*S_bar];
W = [B_in; B_vel_constr];
S = [zeros((2*n/2)*N, n); -(A_vel*T_bar)]; %corrected

end