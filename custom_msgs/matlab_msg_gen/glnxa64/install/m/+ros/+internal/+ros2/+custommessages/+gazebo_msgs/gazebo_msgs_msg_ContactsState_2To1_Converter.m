function ros1msg = gazebo_msgs_msg_ContactsState_2To1_Converter(message,ros1msg)
%gazebo_msgs_msg_ContactsState_2To1_Converter passes data of ROS 2 message to ROS message.
% Copyright 2019 The MathWorks, Inc.    
ros1msg.Header.Stamp.Sec = message.header.stamp.sec;
ros1msg.Header.Stamp.Nsec = message.header.stamp.nanosec;
ros1msg.Header.FrameId = message.header.frame_id{1};
ros1msg.States.Info = message.states.info{1};
ros1msg.States.Collision1Name = message.states.collision1_name{1};
ros1msg.States.Collision2Name = message.states.collision2_name{1};
ros1msg.States.Wrenches.Force.X = message.states.wrenches.force.x;
ros1msg.States.Wrenches.Force.Y = message.states.wrenches.force.y;
ros1msg.States.Wrenches.Force.Z = message.states.wrenches.force.z;
ros1msg.States.Wrenches.Torque.X = message.states.wrenches.torque.x;
ros1msg.States.Wrenches.Torque.Y = message.states.wrenches.torque.y;
ros1msg.States.Wrenches.Torque.Z = message.states.wrenches.torque.z;
ros1msg.States.TotalWrench.Force.X = message.states.total_wrench.force.x;
ros1msg.States.TotalWrench.Force.Y = message.states.total_wrench.force.y;
ros1msg.States.TotalWrench.Force.Z = message.states.total_wrench.force.z;
ros1msg.States.TotalWrench.Torque.X = message.states.total_wrench.torque.x;
ros1msg.States.TotalWrench.Torque.Y = message.states.total_wrench.torque.y;
ros1msg.States.TotalWrench.Torque.Z = message.states.total_wrench.torque.z;
ros1msg.States.ContactPositions.X = message.states.contact_positions.x;
ros1msg.States.ContactPositions.Y = message.states.contact_positions.y;
ros1msg.States.ContactPositions.Z = message.states.contact_positions.z;
ros1msg.States.ContactNormals.X = message.states.contact_normals.x;
ros1msg.States.ContactNormals.Y = message.states.contact_normals.y;
ros1msg.States.ContactNormals.Z = message.states.contact_normals.z;
end