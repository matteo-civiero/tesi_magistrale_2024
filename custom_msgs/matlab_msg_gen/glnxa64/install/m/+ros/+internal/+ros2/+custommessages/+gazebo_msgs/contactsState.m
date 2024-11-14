function [data, info] = contactsState
%ContactsState gives an empty data for gazebo_msgs/ContactsState
% Copyright 2019-2021 The MathWorks, Inc.
data = struct();
data.MessageType = 'gazebo_msgs/ContactsState';
[data.header, info.header] = ros.internal.ros2.messages.std_msgs.header;
info.header.MLdataType = 'struct';
[data.states, info.states] = ros.internal.ros2.custommessages.gazebo_msgs.contactState;
info.states.MLdataType = 'struct';
info.states.MaxLen = NaN;
info.states.MinLen = 0;
info.MessageType = 'gazebo_msgs/ContactsState';
info.constant = 0;
info.default = 0;
info.maxstrlen = NaN;
info.MaxLen = 1;
info.MinLen = 1;
info.MatPath = cell(1,36);
info.MatPath{1} = 'header';
info.MatPath{2} = 'header.stamp';
info.MatPath{3} = 'header.stamp.sec';
info.MatPath{4} = 'header.stamp.nanosec';
info.MatPath{5} = 'header.frame_id';
info.MatPath{6} = 'states';
info.MatPath{7} = 'states.info';
info.MatPath{8} = 'states.collision1_name';
info.MatPath{9} = 'states.collision2_name';
info.MatPath{10} = 'states.wrenches';
info.MatPath{11} = 'states.wrenches.force';
info.MatPath{12} = 'states.wrenches.force.x';
info.MatPath{13} = 'states.wrenches.force.y';
info.MatPath{14} = 'states.wrenches.force.z';
info.MatPath{15} = 'states.wrenches.torque';
info.MatPath{16} = 'states.wrenches.torque.x';
info.MatPath{17} = 'states.wrenches.torque.y';
info.MatPath{18} = 'states.wrenches.torque.z';
info.MatPath{19} = 'states.total_wrench';
info.MatPath{20} = 'states.total_wrench.force';
info.MatPath{21} = 'states.total_wrench.force.x';
info.MatPath{22} = 'states.total_wrench.force.y';
info.MatPath{23} = 'states.total_wrench.force.z';
info.MatPath{24} = 'states.total_wrench.torque';
info.MatPath{25} = 'states.total_wrench.torque.x';
info.MatPath{26} = 'states.total_wrench.torque.y';
info.MatPath{27} = 'states.total_wrench.torque.z';
info.MatPath{28} = 'states.contact_positions';
info.MatPath{29} = 'states.contact_positions.x';
info.MatPath{30} = 'states.contact_positions.y';
info.MatPath{31} = 'states.contact_positions.z';
info.MatPath{32} = 'states.contact_normals';
info.MatPath{33} = 'states.contact_normals.x';
info.MatPath{34} = 'states.contact_normals.y';
info.MatPath{35} = 'states.contact_normals.z';
info.MatPath{36} = 'states.depths';