% precompiled elements for fixed_horizon algorithm
followerParams.precompiledElements.Sd_bar = getSdbar(plant.A, plant.B, N);
followerParams.precompiledElements.Td_bar = getTdbar(plant.A, N);
followerParams.precompiledElements.S_bar = getSbar(plant.A, plant.B, N);
followerParams.precompiledElements.T_bar = getTbar(plant.A, N);
followerParams.precompiledElements.H1 = followerParams.precompiledElements.S_bar'*followerParams.precompiledElements.S_bar;
followerParams.precompiledElements.beta_vec = followerParams.beta .^ (0:(N-1))';
followerParams.precompiledElements.P_bar = kron(eye(N), followerParams.precompiledElements.P);
leaderParams.precompiledElements.P_bar = kron(eye(N), followerParams.precompiledElements.P);
leaderParams.precompiledElements.Sd_bar = followerParams.precompiledElements.Sd_bar;
leaderParams.precompiledElements.Td_bar = followerParams.precompiledElements.Td_bar;
leaderParams.precompiledElements.S_bar = followerParams.precompiledElements.S_bar;
leaderParams.precompiledElements.T_bar = followerParams.precompiledElements.T_bar;