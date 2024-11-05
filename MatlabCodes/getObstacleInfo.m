function [q, d] = getObstacleInfo(o_center, o_radius, x0)
%GETOBSTACLEINFO get qis from obstacles
% x0 is the position of the agent

    [~, obs_n] = size(o_radius);
    if isempty(o_radius)
        q = []; d = [];
    else
        q = zeros(2, obs_n);
        d = zeros(1, obs_n);
        for i = 1:obs_n
            [q(:,i), d(i)] = getqiFromShape(o_center(:,i), o_radius(i), x0);
        end
    end
end

