
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

