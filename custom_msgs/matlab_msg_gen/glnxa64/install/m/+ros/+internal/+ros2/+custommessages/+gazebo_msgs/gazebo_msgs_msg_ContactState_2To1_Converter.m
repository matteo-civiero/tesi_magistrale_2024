function ros1msg = gazebo_msgs_msg_ContactState_2To1_Converter(message,ros1msg)
%gazebo_msgs_msg_ContactState_2To1_Converter passes data of ROS 2 message to ROS message.
% Copyright 2019 The MathWorks, Inc.    
ros1msg.Info = message.info{1};
ros1msg.Collision1Name = message.collision1_name{1};
ros1msg.Collision2Name = message.collision2_name{1};
ros1msg.Wrenches.Force.X = message.wrenches.force.x;
ros1msg.Wrenches.Force.Y = message.wrenches.force.y;
ros1msg.Wrenches.Force.Z = message.wrenches.force.z;
ros1msg.Wrenches.Torque.X = message.wrenches.torque.x;
ros1msg.Wrenches.Torque.Y = message.wrenches.torque.y;
ros1msg.Wrenches.Torque.Z = message.wrenches.torque.z;
ros1msg.TotalWrench.Force.X = message.total_wrench.force.x;
ros1msg.TotalWrench.Force.Y = message.total_wrench.force.y;
ros1msg.TotalWrench.Force.Z = message.total_wrench.force.z;
ros1msg.TotalWrench.Torque.X = message.total_wrench.torque.x;
ros1msg.TotalWrench.Torque.Y = message.total_wrench.torque.y;
ros1msg.TotalWrench.Torque.Z = message.total_wrench.torque.z;
ros1msg.ContactPositions.X = message.contact_positions.x;
ros1msg.ContactPositions.Y = message.contact_positions.y;
ros1msg.ContactPositions.Z = message.contact_positions.z;
ros1msg.ContactNormals.X = message.contact_normals.x;
ros1msg.ContactNormals.Y = message.contact_normals.y;
ros1msg.ContactNormals.Z = message.contact_normals.z;
end