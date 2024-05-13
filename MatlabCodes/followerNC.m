function [c,ceq,gradc,gradceq] = followerNC(U, x0_f, qis, pe, h)
    
    % constant quantities
    S_bar = pe.S_bar;
    T_bar = pe.T_bar;
    P_bar = pe.P_bar;
    P = pe.P;
    v = pe.vertexes;
    p0 = x0_f(1:2);
            
    % there are ( L - # of vertices) * (M - # of constraints) * (N - #
    % istants) to set for equations!
    N = pe.N;
    M = pe.M;
    L = pe.L;
    c = zeros([N*M*L, 1]);
    gradc = zeros([2*N, N*M*L]);
    
    M_allts = h-S_bar*U;
    M_allt_norms = vecnorm(reshape(M_allts, [4, N]))';
    pM_allts = P_bar*M_allts;
    p_f = P_bar*(S_bar*U + T_bar*x0_f);
    PSbar = P_bar*S_bar;
    
    for t = 1:N
        pMt = pM_allts(2*t-1 : 2*t);
        pf_t = p_f(2*t-1 : 2*t);
        PSbar_t = PSbar(2*t-1 : 2*t, :);
        Mt_norm = M_allt_norms(t);
        
        for i = 1:M
            qi = qis(:, i);
            zi = qi-p0;
            
            for j = 1:L
                Rj = [v(1,j), -v(2,j); v(2,j), v(1,j)];
                rij = Rj'*zi;
                
                % inequality fun
                c((t-1)*M*L + (i-1)*L + (j-1) +1) = ...
                    zi' * (pf_t + Rj * (-pMt)/norm(pMt) - qi);
                
                % and grad
                gradc(:, (t-1)*M*L + (i-1)*L + (j-1) +1) =...
                    PSbar_t' * (zi + rij/Mt_norm)...
                    - 1/Mt_norm^3 * pMt' * rij * PSbar_t' * pMt;
            end
        end
    end
    
%     for t = 1:N
%         St = S_bar(4*t-3 : 4*t, :);
%         Tt = T_bar(4*t-3 : 4*t, :);
%         ht = h(4*t-3 : 4*t); % XL(t)-Tt*xF(0)
%         Mt = ht-St*U;
%         
%         for i = 1:M
%             qi = qis(:, i);
%             zi = qi-p0;
%             
%             for j = 1:L
%                 Rj = [v(1,j), -v(2,j); v(2,j), v(1,j)];
%                 
%                 c((t-1)*M*L + (i-1)*L + (j-1) +1) = ...
%                     zi' * (P * (St * U + Tt*x0_f) + Rj * (-P*Mt)/norm(P*Mt) - qi);
%             end
%         end
%     end
    % we have no equality constraint
    ceq = [];
    gradceq = [];
end

    