%-------------------------------------------------------------------------
% This script plots the noise pertubation levels from dynamics IMU_data
%-------------------------------------------------------------------------
close all
clear all

format short e

% Load Data
filename = 'Movement2.dat';

N = importdata(filename);
len = length(N);

% Simulated Noise
R = diag([1.1366e-05 7.5908e-06 7.5601e-06 0.0059 0.0030 0.0034]);   

dt = 0.02;                  %Sampling Frequency
final = (len*dt)-1;
delta_t  = 0:dt:final;      %Simulation steps 
i = 1;                      %loop variable

% Simulated Variables
states  = [5 5 5 1/sqrt(2) 0 0 1/sqrt(2) 0 0 1]; % xv(k)
control = [0 0 9.81 0 0 0];                      %  u(k)
pos_state = zeros(3, size(delta_t,2));
%est_vel = zeros(3, size(delta_t,2));

% Perturbation Levels
r = sqrt(diag(R));

for t = delta_t
    % Read IMU data at appropriate timestep
    control = N(i,:);
    
    % Simulate Actual Data:
    w      = r .* randn(6,1); 
    states = transition_f(states, control, w, dt);
    
    % Collect Data
    pos_state(1,i) = states(1); 
    pos_state(2,i) = states(2);
    pos_state(3,i) = states(3);
    
    i = i + 1;
end
%Split data accordingly
Accel = N(:,1:3);
Gyro  = N(:,4:6);

figure
hold on
plot(pos_state(1,:), '*r');
plot(pos_state(2,:), '--b')
plot(pos_state(3,:), 'g')
hold off

% figure
% hold on
% plot(Accel(:,1), 'r');
% plot(Accel(:,2), 'b')
% plot(Accel(:,3), 'g')
% hold off
% 
% figure
% hold on
% plot(Gyro(:,1), 'r');
% plot(Gyro(:,2), 'b')
% plot(Gyro(:,3), 'g')
% hold off












% % Calculate the trajectory using only the accelerometer measurements 
% 
% dt = 0.02;
% delta_t  = 0:dt:(final*dt); %Simulation steps 
% i = 1;                      %loop variable
% vx = 0;
% vy = 0;
% vz = 0;
% 
% for t = delta_t 
%     control = N(i,:);
%     if norm(q_W) ~= 0
%       q_W = q_W/norm(q_W);
%       q_C = q_W;
%     end
%      
%      a_C = [control(1) control(1) control(1)];
%      v_W = [vx vy vz];
%      omega = [omegaX omegaY omegaZ];
%      
%      if norm(omega) == 0
%          q = q_W;
%          a_W = a_C;
%          v_W = v_W + a_W*dt;
%          
%      else
%          q_C = axis2quat_f(omega,dt);
%          % Updates
%          q = quatmultiply_f(q_W,q_C);
%          a_W = quatrotate_f(q,a_C);
%          v_W = v_W + a_W'*dt;
%      end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Positional Transition
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
%     rx = rx + v_W(1)*dt;
%     ry = ry + v_W(2)*dt;
%     rz = rz + v_W(3)*dt;
% end
