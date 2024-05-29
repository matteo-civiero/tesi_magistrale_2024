clear all;

for simul=1:5
    run("simCooperativeTransport.mlx");
    save("simulations.txt", "execution_time", "-append", "-ascii");
end