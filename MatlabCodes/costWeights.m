function [H,F,Y] = costWeights(A,B,Q,R,P,N)
% COST_WEIGHTS is a function that given the sistem matrices A,B, N predictive horizon and the
% cost weight matrices Q,R,P of an optimal control problem with respect state x and input U return as output
% new cost matrices in order to have a optimization problem only respect
% input U. 

%n state size, m input size
[n,m] = size(B);

%T_bar generation
T_bar = zeros(n*N,n); %initialize T_bar
T_bar(1:n,:) = A;
A_power = A; %auxiliary variable for generation of T_bar 
for i = 2:N
    A_power = A_power*A;
    T_bar((i-1)*n+1:i*n,:) = A_power; 
end
%S_bar generation
S_bar=zeros(n*N,m*N);%initialize S_bar
S_bar_row = [B zeros(n,(N-1)*m)]; 
S_bar(1:n,:) = S_bar_row; 
for i = 2:N
    S_bar_row = [A*S_bar_row(1:n,1:m),S_bar_row(:,1:(N-1)*m)]; 
    S_bar((i-1)*n+1:i*n,:) =  S_bar_row;
end

% input cost
R_bar = kron(eye(N),R);

% state cost
Q_bar = blkdiag(kron(eye(N-1),Q),P);

%H, F, Y generation 
H = zeros(m*N,m*N);
H = 2*(R_bar + S_bar'*Q_bar*S_bar);
F = 2*T_bar'*Q_bar*S_bar;
Y = 2*(Q + T_bar'*Q_bar*T_bar);

end
