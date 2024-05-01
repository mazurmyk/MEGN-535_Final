%% Clear the Workspace variables. 
clear all; close all; clc;
import org.opensim.modeling.*

%% Set variables to use
modelFileName = 'LeftSide.osim';                % The path to an input model
orientationsFileName = 'FinalMotion.sto';       % The path to orientation data for calibration 
sensor_to_opensim_rotation = Vec3(pi/2, 0, 0);  % The rotation of IMU data to the OpenSim world frame 
visualizeTracking = true;                       % Boolean to Visualize the tracking simulation
startTime = 0.01;                               % Start time (in seconds) of the tracking simulation. 
endTime = 60.0;                                 % End time (in seconds) of the tracking simulation.
resultsDirectory = 'IKResults';

%% Instantiate an InverseKinematicsTool
imuIK = IMUInverseKinematicsTool();
 
%% Set the model path to be used for tracking
imuIK.set_model_file(modelFileName);
imuIK.set_orientations_file(orientationsFileName);
imuIK.set_sensor_to_opensim_rotations(sensor_to_opensim_rotation)
% Set time range in seconds
imuIK.set_time_range(0, startTime); 
imuIK.set_time_range(1, endTime);   
% Set a directory for the results to be written to
imuIK.set_results_directory(resultsDirectory)
% Run IK
imuIK.run(visualizeTracking);