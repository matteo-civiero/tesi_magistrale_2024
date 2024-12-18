function [G,W,S] = constraints(A, B, x0, q_points, N, u_max, v_max)
% [G,W,S] = CONSTRAINTS(A, B, x0, q_points, N, u_max, v_max)
% Generate constraints for U in optimization of the type G*U <= W + S(x0) based
% on the positions (in q_points) of the minimum distance points from an
% obstacle, considering as infeasible regions over the tangent to the perpendicular x0-> qi. 
% N is the optimization horizon, A and B are the plant discrete matrices,
% u_max is the maximun accepted value for input in all directions. 
% v_max is the maximun accepted value for velocity in all directions. U is the
% vector of stacket inputs at each time. x0 is the STATE of robot.

% obtain the number of constraints
[~,M] = size(q_points);

% obtain the number of states (n=4) and number of inputs (m=2)
[n,m] = size(B);

% obtain T_bar, the vector of [A; A^2; ... A^N], multiplying x0 to see the
% evolution effect at a generic instant x(t)
T_bar = getTbar(A,N);

% obtain S_bar, the matrix mapping from U vector to the x(t) state, which
% is x(t) = A^t x(0) + A^t-1 B u(t-1) + A^t-2 B u(t-2) + ... 
S_bar = getSbar(A,B,N);

% prepare constraints for input (max accelerations)
% just require that each component of acceleration is such that |u_xy|<amax
G_acc_constr = [1 0; -1 0; 0 1; 0 -1]; % multiplicator to u (2 coords, 2 bounds)
G_in = kron(eye(N), G_acc_constr); % this requirement must hold for all times
B_in = repmat([1; 1; 1; 1]*u_max, N, 1); % repeat vertically as the bound affects each time

% prepare constraints for velocity
% just require that each component of velocity is such that |v_xy|<vmax
A_vel_constr = [0, 0, 1, 0; 0, 0, -1, 0; 0, 0, 0, 1; 0, 0, 0, -1];% multiplicator to x (4 coords, 2 bounds)
A_vel = kron(eye(N), A_vel_constr);
B_vel_constr = repmat( [1; 1; 1; 1]*v_max , N, 1);

% eventually add constraints using the polytopes
if M >= 1
    % The constraints are linear as (qi-x0)' x(t) <= (qi-x0)'qi.
    % stack them to obtain the form Ac*x(t)<=bc -> this is for one t
    A_constr = zeros([M, n]);
    b_constr = zeros([M, 1]);
    for i = 1:M
        A_constr(i,:) = [(q_points(:,i) - x0(1:2))', 0 , 0];
        b_constr(i) = (q_points(:,i) - x0(1:2))'*q_points(:,i);
    end
    
    % stack diagonally to expand and make it a bound for all ts
    A_bar = kron(eye(N),A_constr);
    B_bar = repmat(b_constr, N, 1);

    % convert it to a request in U (all ts) and concat requests on inputs
    G = [A_bar*S_bar; G_in; A_vel*S_bar];
    W = [B_bar; B_in; B_vel_constr];
    S = [-(A_bar*T_bar); zeros(4*N, n); zeros(4*N, n)];
    
else % if there are no constraints, just add Gu<=W+Sx0 to limit input
    G = [G_in; A_vel*S_bar];
    W = [B_in; B_vel_constr];
    S = [zeros(4*N, n); zeros(4*N, n)];
end

end