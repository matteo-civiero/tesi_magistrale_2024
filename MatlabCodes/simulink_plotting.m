close all

figure;
hold on; grid on;
% trajectory plotting
plot(out.x_l.signals.values(:,1), out.x_l.signals.values(:,2), "-o", "Color", 'r');
plot(out.x_f.signals.values(:,1), out.x_f.signals.values(:,2), "-o", "Color", 'b');
plotObstacles(obstacles);
xlabel("Coordinate x [m]","Interpreter","latex", "FontSize", 20)
ylabel("Coordinate y [m]","Interpreter","latex", "FontSize", 20)
legend("Leader Robot","Follower Robot","Location","southeast","Interpreter","latex", "FontSize", 15)

% formation error plotting
figure;
hold on; grid on;
plot(out.fe.time, out.fe.signals.values(:), "LineWidth", 2);
% xlim([0, 42.1]);
% ylim([-0.8, 0.6]);
xlabel("Time [s]", "Interpreter","latex", "FontSize", 20)
ylabel("$fe_{L,F}(t)$ [m]", "Interpreter","latex", "FontSize", 20)

% collision detection
figure;
hold on; grid on;
plot(out.leader_collision.time, out.leader_collision.signals.values(:), 'r', "Marker", "square");
plot(out.follower_collision.time, out.follower_collision.signals.values(:), 'b', "Marker", "diamond");
plot(out.load_collision.time, out.load_collision.signals.values(:), 'g', "Marker", "^");
ylim([0 1.1]);
legend("Leader Collision","Follower Collision", "Load Collision", "Interpreter","latex", "FontSize", 15);
xlabel("Time [s]", "Interpreter","latex", "FontSize", 20);

% position tracking
figure;
hold on; grid on;
plot(out.x_l_ref.time, out.x_l_ref.signals.values(:,1), "LineWidth", 3);
plot(out.x_l.time, out.x_l.signals.values(:,1), "--", "LineWidth", 3);
plot(out.x_l_ref.time, out.x_l_ref.signals.values(:,2), "LineWidth", 3);
plot(out.x_l.time, out.x_l.signals.values(:,2), "--", "LineWidth", 3);
plot(out.x_l_ref.time, out.x_l_ref.signals.values(:,3), "LineWidth", 3);
plot(out.x_l.time, out.x_l.signals.values(:,3), "--", "LineWidth", 3);

max_form_err = max(abs(out.fe.signals.values(:)));
mean_form_err = mean(abs(out.fe.signals.values(:)));