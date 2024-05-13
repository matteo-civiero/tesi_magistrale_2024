function Sd_bar = getSdbar(A, B, N)
%   Detailed explanation goes here

[n,m] = size(B);

% obtain S_bar, the matrix mapping from U vector to the x(t) state, which
% is x(t) = A^t x(0) + A^t-1 B u(t-1) + A^t-2 B u(t-2) + ... 
A_I = A - eye(n); 
Sd_bar = zeros(n*N,m*N);
S_bar_row = [B zeros(n,(N-1)*m)]; % start as [B 0 0 0 0 0]
Sd_bar(1:n,:) = S_bar_row; % assign first block row
S_bar_row = [A_I*B, B zeros(n,(N-2)*m)];
Sd_bar(n+1:2*n,:) = S_bar_row;
for i = 3:N % at each iteration move to right and multiply by A -> [A2B AB B 0 0 0]
    S_bar_row = [A*S_bar_row(1:n,1:m), S_bar_row(:,1:(N-1)*m)]; 
    Sd_bar((i-1)*n+1:i*n,:) =  S_bar_row;
end

end

