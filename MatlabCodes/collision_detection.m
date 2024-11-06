function [collision_l, collision_f, collision_load] = collision_detection(x_l, x_f, loadTheta, leaderParams, followerParams, M_leader, M_follower, obstacles)
%COLLISION_DETECTION Function that detects collision between agent and
%obstacle
%   x is the agent state, params are the agent parameters, obstacles
%   contains obs info
collision_l = false;
collision_f = false;
collision_load = false;

for i=1:M_leader
    for j=1:leaderParams.L
        if (vecnorm((x_l(1:2) + Rmat(x_l(3))*leaderParams.initRobotShape(:,j)) - obstacles{i}.center) - obstacles{i}.radius < 0)
            collision_l = true;
        end
    end
end

for i=1:M_follower
    for j=1:followerParams.vertexes
        if (vecnorm((x_f(1:2) + Rmat(x_f(3))*followerParams.initRobotShape(:,j)) - obstacles{i}.center) - obstacles{i}.radius < 0)
            collision_f = true;
        end
    end
end

for i=1:M_follower
    for j=1:(followerParams.L - followerParams.vertexes)
        if (vecnorm((x_f(1:2) + Rmat(loadTheta)*followerParams.initLoadShape(:,j)) - obstacles{i}.center) - obstacles{i}.radius < 0)
            collision_load = true;
        end
    end
end

end

