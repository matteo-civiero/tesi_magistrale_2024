function Td_bar = getTdbar(A, N)
%GETTDBAR Summary of this function goes here
%   Detailed explanation goes here
[n,~] = size(A);

% obtain T_bar, the vector of [A^0(A-I); A^1*(A - I); ... A^(N-1)*(A - I)], multiplying x0 to see the
% evolution effect at a generic instant x(t)
A_I = A - eye(n); 
Td_bar = zeros(n*N,n);
Td_bar(1:n,:) = A_I*A^0;
for i = 1:N-1
    Td_bar((i)*n+1:(i+1)*n,:) = Td_bar((i-1)*n+1:i*n,:)*A; 
end

end

