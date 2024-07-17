function [c, ceq] = non_linear_constr_leader(U, q_points, x0, N, n, M, L, initRobotShape, T_bar, S_bar)
%NON_LINEAR_CONSTR Summary of this function goes here
%   Detailed explanation goes here

% implementation of non linear contraints for the obstacle avoidance with
% rotation of the agents
p0 = x0(1:2); % initial position of agent
x_t = (T_bar * x0 + S_bar * U);
k = 1;
if M>=1
    for t=1:N
        for i=1:M
            qi = q_points(:,i);
            for j=1:L
                vj = initRobotShape(:, j);
                c(k,1) = -((qi - p0)' * (qi - (x_t((n*(t-1)+1):(n*t-(n-2))) + Rmat(x_t(n*t-(n-3))) * vj)));
                k = k + 1;
                % x_t((n*(t-1)+1):(n*t-(n-2)) are x and y position in every
                % step
                % x_t(n*t-(n-3)) is the orientation in every step
            end
        end
    end
else
    c = [];
end
ceq = [];
end

