
time = 0:Ts:Ts*(i-2);

followerParams.loadShape = Rmat(loadTheta(i-1))*followerParams.initLoadShape;

% Trajectory plot
figure;  hold on; grid on;
plot( x_l(1,1:(i-1)), x_l(2,1:(i-1)), "-o","Color", "red");
plot( x_f(1,1:(i-1)), x_f(2,1:(i-1)), "-o","Color", "blue")
plotObstacles(obstacles);
plot(...
   polyshape(x_f(1,end)+followerParams.loadShape(1,:),...
             x_f(2,end)+followerParams.loadShape(2,:)),...
   'FaceColor',followerParams.pos_color,'FaceAlpha',0.5);
%title("\textbf{Leader-Follower Trajectory}","Interpreter","latex", "FontSize", 14)
xlabel("Coordinate x [m]","Interpreter","latex", "FontSize", 20)
ylabel("Coordinate y [m]","Interpreter","latex", "FontSize", 20)
legend("Leader Robot","Follower Robot","Location","southeast","Interpreter","latex", "FontSize", 15)

% Coordinates evolution and formation error plot
figure; 
hold on; grid on;
plot(time, x_l(1,1:(i-1)), "-b", "LineWidth", 2);
plot(time, x_l(2,1:(i-1)), "Color", "black", "LineStyle", "-", "LineWidth", 2);
plot(time, x_f(1,1:(i-1)), "--r", "LineWidth", 2);
plot(time, x_f(2,1:(i-1)), "Color", "#FF00FF", "LineStyle", "--", "LineWidth", 2);
xlabel("Time [s]", "Interpreter","latex","FontSize", 20)
ylabel("$x$ \ $y$ [m]", "Interpreter","latex", "FontSize", 20)
%title("\textbf{Agents position evolution}", "Interpreter","latex", "FontSize", 14)
legend("$x^{L}$","$y^{L}$","$x^{F}$","$y^{F}$","Interpreter","latex", "FontSize", 15)
figure;
hold on; grid on;
plot(time, x_l(3,1:(i-1)), "-g", "LineWidth", 2);
plot(time, x_f(3,1:(i-1)), "Color", "#77AC30", "LineStyle", "-", "LineWidth", 2);
xlabel("Time [s]", "Interpreter","latex","FontSize", 14)
ylabel("$\theta$ [rad]", "Interpreter","latex", "FontSize", 14)
title("\textbf{Agents orientation evolution}", "Interpreter","latex", "FontSize", 14)
legend("$\theta_{L}$","$\theta_{F}$","Interpreter","latex", "FontSize", 12)

vel = figure;
hold on;
grid on;
plot(time, x_l(4,1:(i-1)), "-b", "LineWidth", 2);
plot(time, x_l(5,1:(i-1)), "Color", "black", "LineStyle", "-", "LineWidth", 2);
plot(time, x_f(4,1:(i-1)), "--r", "LineWidth", 2);
plot(time, x_f(5,1:(i-1)), "Color", "#FF00FF", "LineStyle", "--", "LineWidth", 2);
set(gca, "FontSize", 20);
xlabel("Time [s]", "Interpreter","latex","FontSize", 40)
ylabel("$v_x$/$v_y$ [m/s]", "Interpreter","latex", "FontSize", 40)
%title("\textbf{Agents velocity evolution}", "Interpreter","latex", "FontSize", 14)
legend("$v_{x}^L$","$v_{y}^L$","$v_{x}^F$","$v_{y}^F$","Interpreter","latex", "FontSize", 22)

figure;
hold on;
grid on;
plot(time, x_l(6,1:(i-1)), "-g", "LineWidth", 2);
plot(time, x_f(6,1:(i-1)), "Color", "#77AC30", "LineStyle", "-", "LineWidth", 2);
xlabel("Time [s]", "Interpreter","latex","FontSize", 14)
ylabel("$\omega$ [rad/s]", "Interpreter","latex", "FontSize", 14)
title("\textbf{Agents angular velocity evolution}", "Interpreter","latex", "FontSize", 14)
legend("$\omega_{L}$","$\omega_{F}$","Interpreter","latex", "FontSize", 12)

figure;
hold on; grid on;
plot(time(1:end),real_d - followerParams.d_FL, "LineWidth", 2);
grid on;
% xlim([0, 42.1]);
% ylim([-0.02, 0.01]);
xlabel("Time [s]", "Interpreter","latex", "FontSize", 20);
ylabel("$fe_{L,F}(t)$ [m]", "Interpreter","latex", "FontSize", 20);

%%

collisions = ros2message("gazebo_msgs/ContactsState");
collisions = ros2bagreader("/home/matteociviero/rosbag_collisions/prova_1");

