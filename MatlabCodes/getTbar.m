function T_bar = getTbar(A, N)
%GETTBAR Summary of this function goes here
%   Detailed explanation goes here


[n,~] = size(A);

% obtain T_bar, the vector of [A; A^2; ... A^N], multiplying x0 to see the
% evolution effect at a generic instant x(t)
T_bar = zeros(n*N,n);
T_bar(1:n,:) = A;
for i = 1:N-1
    T_bar((i)*n+1:(i+1)*n,:) = T_bar((i-1)*n+1:i*n,:)*A; 
end

end

