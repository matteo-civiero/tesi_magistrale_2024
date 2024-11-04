function state = convert_msg_to_state(msg)
%LEADER_STATE_CALLBACK CallBack function that reads leader state
%   CallBack function that reads leader state from topic
%   /leader_odom/leader_odom. It gets a pose, quaternion, linear and angular
%   velocities. Returns the state.

x = msg.pose.pose.position.x;
y = msg.pose.pose.position.y;
% [heading, ~, ~]  = quat2angle([msg.pose.pose.orientation.x msg.pose.pose.orientation.y msg.pose.pose.orientation.z msg.pose.pose.orientation.w], 'ZYX');
heading = msg.pose.pose.orientation.z;
vx = msg.twist.twist.linear.x;
vy = msg.twist.twist.linear.y;
omega = msg.twist.twist.angular.z;

state = [x y heading vx vy omega]';
end

