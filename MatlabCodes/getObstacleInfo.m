function [q, d] = getObstacleInfo(obstacles, x0)
%GETOBSTACLEINFO get qis from obstacles
% x0 is the position of the agent

    [~, obs_n] = size(obstacles);
    if isempty(obstacles)
        q = []; d = [];
    else
        for i = 1:obs_n
            [q(:,i), d(i)] = getqiFromShape(obstacles{i}, x0);
        end
    end
end

