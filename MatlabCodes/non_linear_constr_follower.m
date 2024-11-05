function [c, ceq] = non_linear_constr_follower(U, q_points, q_load, x0, N, n, M, vertexes, L, initRobotShape, initLoadShape, loadCenter, T_bar, S_bar, x_l, loadTheta0)
%NON_LINEAR_CONSTR Computes the non linear obstacle avoidance contraints for the follower and the load 
%   Non linear obstacle avoidance contraints for the follower and the load,
%   considering the geometrical approach that compares the position of
%   every vertex during the horizon with the half plane drew in the first
%   step of the horizon. This approach is not compatible with the
%   leader-follower avoidance commented at the bottom and probably with a more dynamic environment.

% implementation of non linear contraints for the obstacle avoidance with
% rotation of the agents
p0 = x0(1:2); % initial position of agent
x_t = (T_bar * x0 + S_bar * U);
k = 1;
if M>=1
    c = zeros(N*M*L);
    for t=1:N
        for i=1:M
            qi = q_points(:,i);
            ql = q_load(:,i);
            for j=1:L
                if j <= vertexes
                    vj = initRobotShape(:, j);
                    c(k,1) = -((qi - p0)' * (qi - (x_t((n*(t-1)+1):(n*(t-1)+2)) + Rmat(x_t(n*(t-1)+3)) * vj)));
                    k = k + 1;
                    % x_t((n*(t-1)+1):(n*(t-1)+2)) are x and y position in every
                    % step
                    % x_t(n*(t-1)+3)) is the orientation in every step
                else
                    vj = initLoadShape(:, j - vertexes);
                    fl_diff = x_t((n*(t-1)+1):(n*(t-1)+2)) - x_l((n*(t-1)+1):(n*(t-1)+2));
                    loadTheta = atan2(fl_diff(2), fl_diff(1));
                    c(k,1) = -((ql - (p0 + Rmat(loadTheta0) * loadCenter))' * (ql - (x_t((n*(t-1)+1):(n*(t-1)+2)) + Rmat(loadTheta) * vj)));
                    k = k + 1;
                    % x_t((n*(t-1)+1):(n*(t-1)+2)) are x and y position in every
                    % step
                end
            end
        end
    end
else
    c = [];
end

% % leader collision avoidance
% leader.type = leaderParams.shape;
% leader.center = x_l(1:2);
% if leader.type == "circle"
%     leader.radius = leaderParams.max_radius;
% elseif leader.type == "ellipse"
%     leader.a = leaderParams.a;
%     leader.b = leaderParams.b;
% end
% leader.theta = x_l(3);
% q_leader = getqiFromShape(leader, p0);
% for t = 1:N
%     for j = 1:vertexes
%         vj = initRobotShape(:, j);
%         c(k,1) = -((q_leader - p0)' * (q_leader - (x_t((n*(t-1)+1):(n*t-(n-2))) + Rmat(x_t(n*t-(n-3))) * vj)));
%         k = k + 1;
%         % x_t((n*(t-1)+1):(n*t-(n-2)) are x and y position in every
%         % step
%         % x_t(n*t-(n-3)) is the orientation in every step
%     end
% end

ceq = [];
end

