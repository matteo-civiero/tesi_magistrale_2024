function [y, x_k1] = modelDynamics(A, B, C, D, x_k, u_k)
% MODELDYNAMIC receives as input the system model, the state at time k and
% the input at time k, and give in output the state at time k+1 and the
% output at time k.
% 

x_k1 = A*x_k + B*u_k;
y = C*x_k;
end

