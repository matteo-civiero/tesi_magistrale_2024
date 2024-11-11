function ros2msg = gazebo_msgs_msg_ContactState_1To2_Converter(message,ros2msg)
%gazebo_msgs_msg_ContactState_1To2_Converter passes data of ROS message to ROS 2 message.
% Copyright 2019 The MathWorks, Inc.
ros2msg.info = message.Info;
ros2msg.collision1_name = message.Collision1Name;
ros2msg.collision2_name = message.Collision2Name;
ros2msg.wrenches.force.x = message.Wrenches.Force.X;
ros2msg.wrenches.force.y = message.Wrenches.Force.Y;
ros2msg.wrenches.force.z = message.Wrenches.Force.Z;
ros2msg.wrenches.torque.x = message.Wrenches.Torque.X;
ros2msg.wrenches.torque.y = message.Wrenches.Torque.Y;
ros2msg.wrenches.torque.z = message.Wrenches.Torque.Z;
ros2msg.total_wrench.force.x = message.TotalWrench.Force.X;
ros2msg.total_wrench.force.y = message.TotalWrench.Force.Y;
ros2msg.total_wrench.force.z = message.TotalWrench.Force.Z;
ros2msg.total_wrench.torque.x = message.TotalWrench.Torque.X;
ros2msg.total_wrench.torque.y = message.TotalWrench.Torque.Y;
ros2msg.total_wrench.torque.z = message.TotalWrench.Torque.Z;
ros2msg.contact_positions.x = message.ContactPositions.X;
ros2msg.contact_positions.y = message.ContactPositions.Y;
ros2msg.contact_positions.z = message.ContactPositions.Z;
ros2msg.contact_normals.x = message.ContactNormals.X;
ros2msg.contact_normals.y = message.ContactNormals.Y;
ros2msg.contact_normals.z = message.ContactNormals.Z;
end