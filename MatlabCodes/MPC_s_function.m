function MPC_s_function(block)
%MSFUNTMPL_BASIC A Template for a Level-2 MATLAB S-Function
%   The MATLAB S-function is written as a MATLAB function with the
%   same name as the S-function. Replace 'msfuntmpl_basic' with the 
%   name of your S-function.

%   Copyright 2003-2018 The MathWorks, Inc.

%%
%% The setup method is used to set up the basic attributes of the
%% S-function such as ports, parameters, etc. Do not add any other
%% calls to the main body of the function.
%%
setup(block);

%endfunction

%% Function: setup ===================================================
%% Abstract:
%%   Set up the basic characteristics of the S-function block such as:
%%   - Input ports
%%   - Output ports
%%   - Dialog parameters
%%   - Options
%%
%%   Required         : Yes
%%   C MEX counterpart: mdlInitializeSizes
%%
function setup(block)

% Register number of ports
block.NumInputPorts  = 3; % x_l, x_f, loadTheta
block.NumOutputPorts = 2; % x_l_pred, x_f_pred

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

block.InputPort(1).Dimensions = 6;
block.InputPort(2).Dimensions = 6;
block.InputPort(3).Dimensions = 1;

block.OutputPort(1).Dimensions = 6;
block.OutputPort(2).Dimensions = 6;


% Register parameters
block.NumDialogPrms     = 25; % sim_perception_range, fixed_horizon, alg_fmincon, obs_centers, N, N_long, N_short, U_l_old, U_f_old, n, m, leaderParams, followerParams, plant, P, eps_loose_grip, k_loose_grip, perception_range, policy_halt, obs_radius, obs_velocities, M, Ts, x_l_0, x_f_0
block.DialogPrmsTunable = {'NonTunable', 'NonTunable', 'NonTunable', 'Nontunable', 'Nontunable', 'NonTunable', 'NonTunable', 'Nontunable', 'Nontunable', 'NonTunable', 'NonTunable', 'NonTunable', 'NonTunable', 'NonTunable', 'NonTunable', 'NonTunable', 'NonTunable', 'NonTunable', 'NonTunable', 'Nontunable', 'Nontunable', 'Nontunable', 'Nontunable', 'Nontunable', 'Nontunable'};

% Register sample times
%  [0 offset]            : Continuous sample time
%  [positive_num offset] : Discrete sample time
%
%  [-1, 0]               : Inherited sample time
%  [-2, 0]               : Variable sample time
block.SampleTimes = [block.DialogPrm(23).Data 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'CustomSimState',  < Has GetSimState and SetSimState methods
%    'DisallowSimState' < Error out when saving or restoring the model sim state
block.SimStateCompliance = 'DefaultSimState';

%% -----------------------------------------------------------------
%% The MATLAB S-function uses an internal registry for all
%% block methods. You should register all relevant methods
%% (optional and required) as illustrated below. You may choose
%% any suitable name for the methods and implement these methods
%% as local functions within the same file. See comments
%% provided for each function for more information.
%% -----------------------------------------------------------------

block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
% block.RegBlockMethod('InitializeConditions', @InitializeConditions);
block.RegBlockMethod('Start', @Start);
block.RegBlockMethod('Outputs', @Outputs);     % Required
block.RegBlockMethod('Update', @Update);
% block.RegBlockMethod('Derivatives', @Derivatives);
block.RegBlockMethod('Terminate', @Terminate); % Required

%end setup

%%
%% PostPropagationSetup:
%%   Functionality    : Setup work areas and state variables. Can
%%                      also register run-time methods here
%%   Required         : No
%%   C MEX counterpart: mdlSetWorkWidths
%%
function DoPostPropSetup(block)

if block.DialogPrm(22).Data > 0
    block.NumDworks = 6;

    block.Dwork(1).Name = 'N';
    block.Dwork(1).DatatypeID = 0;
    block.Dwork(1).Dimensions = 1;
    block.Dwork(1).Complexity = "Real";
    
    block.Dwork(2).Name = 'U_l_old';
    block.Dwork(2).DatatypeID = 0;
    block.Dwork(2).Dimensions = block.DialogPrm(11).Data*block.DialogPrm(5).Data;
    block.Dwork(2).Complexity = "Real";
    
    block.Dwork(3).Name = 'U_f_old';
    block.Dwork(3).DatatypeID = 0;
    block.Dwork(3).Dimensions = block.DialogPrm(11).Data*block.DialogPrm(5).Data;
    block.Dwork(3).Complexity = "Real";

    block.Dwork(4).Name = 'obs_centers';
    block.Dwork(4).Dimensions = 2*block.DialogPrm(22).Data;
    block.Dwork(4).DatatypeID = 0;
    block.Dwork(4).Complexity = "Real";
    
    block.Dwork(5).Name = 'obs_radius';
    block.Dwork(5).Dimensions = block.DialogPrm(22).Data;
    block.Dwork(5).DatatypeID = 0;
    block.Dwork(5).Complexity = "Real";
    
    block.Dwork(6).Name = 'obs_vel';
    block.Dwork(6).Dimensions = 2*block.DialogPrm(22).Data;
    block.Dwork(6).DatatypeID = 0;
    block.Dwork(6).Complexity = "Real";
else
    block.NumDworks = 3;

    block.Dwork(1).Name = 'N';
    block.Dwork(1).DatatypeID = 0;
    block.Dwork(1).Dimensions = 1;
    block.Dwork(1).Complexity = "Real";
    
    block.Dwork(2).Name = 'U_l_old';
    block.Dwork(2).DatatypeID = 0;
    block.Dwork(2).Dimensions = block.DialogPrm(11).Data*block.DialogPrm(5).Data;
    block.Dwork(2).Complexity = "Real";
    
    block.Dwork(3).Name = 'U_f_old';
    block.Dwork(3).DatatypeID = 0;
    block.Dwork(3).Dimensions = block.DialogPrm(11).Data*block.DialogPrm(5).Data;
    block.Dwork(3).Complexity = "Real";
end



%%
%% InitializeConditions:
%%   Functionality    : Called at the start of simulation and if it is 
%%                      present in an enabled subsystem configured to reset 
%%                      states, it will be called when the enabled subsystem
%%                      restarts execution to reset the states.
%%   Required         : No
%%   C MEX counterpart: mdlInitializeConditions
%%
% function InitializeConditions(block)

%end InitializeConditions


%%
%% Start:
%%   Functionality    : Called once at start of model execution. If you
%%                      have states that should be initialized once, this 
%%                      is the place to do it.
%%   Required         : No
%%   C MEX counterpart: mdlStart
%%
function Start(block)

block.Dwork(1).Data = block.DialogPrm(5).Data;
block.Dwork(2).Data = block.DialogPrm(8).Data;
block.Dwork(3).Data = block.DialogPrm(9).Data;
if block.DialogPrm(22).Data > 0
    block.Dwork(4).Data = block.DialogPrm(4).Data; % obs_centers
    block.Dwork(5).Data = block.DialogPrm(20).Data; % obs_radius
    block.Dwork(6).Data = block.DialogPrm(21).Data; % obs_vels
end

x_l_0 = block.DialogPrm(24).Data;
block.OutputPort(1).Data = x_l_0;
x_f_0 = block.DialogPrm(25).Data;
block.OutputPort(2).Data = x_f_0;

%end Start

%%
%% Outputs:
%%   Functionality    : Called to generate block outputs in
%%                      simulation step
%%   Required         : Yes
%%   C MEX counterpart: mdlOutputs
%%
function Outputs(block)

sim_perception_range =  block.DialogPrm(1).Data;
fixed_horizon = block.DialogPrm(2).Data;
alg_fmincon = block.DialogPrm(3).Data;
M = block.DialogPrm(22).Data;
if M > 0
    obs_centers = block.Dwork(4).Data;
    obs_radius = block.Dwork(5).Data;
    obs_vels = block.Dwork(6).Data;
    obs_centers = reshape(obs_centers, [2 M]);
    obs_vels = reshape(obs_vels, [2 M]);
    obstacles = cell(M);
    for i=1:M
        obstacles{i}.center = obs_centers(:,i);
        obstacles{i}.radius = obs_radius(i);
        obstacles{i}.velocity = obs_vels(:,i);
        obstacles{i}.type = "circle";
    end
else
    obstacles = [];
end
N = block.Dwork(1).Data;
N_long = block.DialogPrm(6).Data;
N_short = block.DialogPrm(7).Data;
U_l_old = block.Dwork(2).Data;
U_f_old = block.Dwork(3).Data;
n = block.DialogPrm(10).Data; 
m = block.DialogPrm(11).Data;
leaderParams = block.DialogPrm(12).Data;
followerParams = block.DialogPrm(13).Data;
plant = block.DialogPrm(14).Data; 
P = block.DialogPrm(15).Data;
eps_loose_grip = block.DialogPrm(16).Data;
k_loose_grip = block.DialogPrm(17).Data;
perception_range = block.DialogPrm(18).Data;
policy_halt = block.DialogPrm(19).Data;

% see function declaration, the dialog params order is the same
[block.OutputPort(1).Data, block.OutputPort(2).Data, N, U_l_old, U_f_old] = MPC(block.InputPort(1).Data, ...
    block.InputPort(2).Data, block.InputPort(3).Data, sim_perception_range, fixed_horizon, alg_fmincon, obstacles, N, N_long, N_short, U_l_old, ...
    U_f_old, n, m, leaderParams, followerParams, plant, P, eps_loose_grip, k_loose_grip, perception_range, policy_halt);

%end Outputs

%%
%% Update:
%%   Functionality    : Called to update discrete states
%%                      during simulation step
%%   Required         : No
%%   C MEX counterpart: mdlUpdate
%%
function Update(block)

if block.DialogPrm(22).Data > 0
    Ts = block.DialogPrm(23).Data;
    block.Dwork(4).Data = block.Dwork(4).Data + block.Dwork(6).Data*Ts;
end

%end Update

%%
%% Derivatives:
%%   Functionality    : Called to update derivatives of
%%                      continuous states during simulation step
%%   Required         : No
%%   C MEX counterpart: mdlDerivatives
%%
%function Derivatives(block)

%end Derivatives

%%
%% Terminate:
%%   Functionality    : Called at the end of simulation for cleanup
%%   Required         : Yes
%%   C MEX counterpart: mdlTerminate
%%
function Terminate(block)

%end Terminate