leader_state_node = ros2node('/leader_state');
follower_state_node = ros2node('/follower_state');
leader_input_node = ros2node('/leader_input');
follower_input_node = ros2node('/follower_input');

leader_state = ros2subscriber(leader_state_node, "/leader_odom/leader_odom", "nav_msgs/Odometry");
follower_state = ros2subscriber(follower_state_node, "/follower_odom/follower_odom", "nav_msgs/Odometry");
leader_input = ros2publisher(leader_input_node, "/leader_cf/gazebo_ros_force", "geometry_msgs/Wrench");
follower_input = ros2publisher(follower_input_node, "/follower_cf/gazebo_ros_force", "geometry_msgs/Wrench");

for i = 1:1001
    tic;
    f_f = ros2message("geometry_msgs/Wrench");
    f_f.force.x = out.fx.signals.values(i);
    f_f.force.y = out.fy.signals.values(i);
    f_f.force.z = 0;
    f_f.torque.x = 0;
    f_f.torque.y = 0;
    f_f.torque.z = 0;

    send(follower_input, f_f);
    position = receive(follower_state);
    x(i) = position.pose.pose.position.x;
    y(i) = position.pose.pose.position.y;

    while toc < 0.01

    end
end
%%
figure;
hold on; grid on;
plot(x, y);
xlim([-2 2]);
ylim([-3 1]);