function [J] = leaderCostFunHalt(U, x0, T_bar, S_bar, C, decay, vertexes, M, L, N, n, obstalces, crit_dist)
%LEADERCOSTFUN functional cost for leader
%   navigation cost + potential repulsion cost

% navigation cost
x_t = (T_bar * x0 + S_bar * U);
J1 = 0;
for t = 1:(N-1)
    % distance between position(t+1) and position(t)
    J1 = J1 + norm(x_t((n*(t-1)+1 + n):(n*t-(n-2) + n)) - x_t((n*(t-1)+1):(n*t-(n-2))))^2;
end

% potential repulsion
J3 = 0;

if crit_dist
    for i = 1:M
        for j = 1:L
            for t = 1:N
                % x_t((n*(t-1)+1):(n*t-(n-2)) is position(t)
                J3 = J3 + C * exp(-decay * (norm(x_t((n*(t-1)+1):(n*t-(n-2))) + Rmat(x_t(n*t-(n-3))) * vertexes(:,j) - obstalces{i}.center) - obstalces{i}.radius));
            end
        end
    end
end

J = J1 + J3;

end 

