function [J] = leaderCostFun(U, H, f, x0, T_bar, S_bar, C, decay, vertexes, M, L, N, n, obstacles, crit_dist)
%LEADERCOSTFUN functional cost for leader
%   navigation cost + potential repulsion cost

% classic cost
J1 = 0.5 * U' * H * U;
J2 = f' * U;

J3 = 0;

if (crit_dist) && (M > 0)
    % potential field cost
    x_t = (T_bar * x0 + S_bar * U);
    for i = 1:M
        for j = 1:L
            for t = 1:N
                J3 = J3 + C * exp(-decay * (norm(x_t((n*(t-1)+1):(n*t-(n-2))) + Rmat(x_t(n*t-(n-3))) * vertexes(:,j) - obstacles{i}.center) - obstacles{i}.radius));
            end
        end
    end
end

J = J1 + J2 + J3;
end 

