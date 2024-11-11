function ros2msg = gazebo_msgs_msg_ContactsState_1To2_Converter(message,ros2msg)
%gazebo_msgs_msg_ContactsState_1To2_Converter passes data of ROS message to ROS 2 message.
% Copyright 2019 The MathWorks, Inc.
ros2msg.header.stamp.sec = message.Header.Stamp.Sec;
ros2msg.header.stamp.nanosec = message.Header.Stamp.Nsec;
ros2msg.header.frame_id = message.Header.FrameId;
ros2msg.states.info = message.States.Info;
ros2msg.states.collision1_name = message.States.Collision1Name;
ros2msg.states.collision2_name = message.States.Collision2Name;
ros2msg.states.wrenches.force.x = message.States.Wrenches.Force.X;
ros2msg.states.wrenches.force.y = message.States.Wrenches.Force.Y;
ros2msg.states.wrenches.force.z = message.States.Wrenches.Force.Z;
ros2msg.states.wrenches.torque.x = message.States.Wrenches.Torque.X;
ros2msg.states.wrenches.torque.y = message.States.Wrenches.Torque.Y;
ros2msg.states.wrenches.torque.z = message.States.Wrenches.Torque.Z;
ros2msg.states.total_wrench.force.x = message.States.TotalWrench.Force.X;
ros2msg.states.total_wrench.force.y = message.States.TotalWrench.Force.Y;
ros2msg.states.total_wrench.force.z = message.States.TotalWrench.Force.Z;
ros2msg.states.total_wrench.torque.x = message.States.TotalWrench.Torque.X;
ros2msg.states.total_wrench.torque.y = message.States.TotalWrench.Torque.Y;
ros2msg.states.total_wrench.torque.z = message.States.TotalWrench.Torque.Z;
ros2msg.states.contact_positions.x = message.States.ContactPositions.X;
ros2msg.states.contact_positions.y = message.States.ContactPositions.Y;
ros2msg.states.contact_positions.z = message.States.ContactPositions.Z;
ros2msg.states.contact_normals.x = message.States.ContactNormals.X;
ros2msg.states.contact_normals.y = message.States.ContactNormals.Y;
ros2msg.states.contact_normals.z = message.States.ContactNormals.Z;
end