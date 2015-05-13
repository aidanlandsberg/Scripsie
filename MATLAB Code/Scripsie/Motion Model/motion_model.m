%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Motion_Modelling_Simulation_Suite: Simulations for monocular SLAM 
%
% Motion_model.m
% Copyright (C) University of Stellenbosch
%
% Author
% Aidan Landsberg
% 16579038@sun.ac.za
%
% This suite is designed to simulate the effects of a 3-D motion model that 
% that is to be utilised by an extended Kalman filter in order to implement
% SLAM. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) Initialise Variable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all

% Set the format to 5-digit scaled floating point
format short e

dt = 1/100;                          % Sampling time delta T
%R = diag(1*ones(1,6).^2);           % Accell and Gyro Noise  
R = diag([1.1366e-05 7.5908e-06 7.5601e-06 0.0059 0.0030 0.0034]);
Q = diag(1e-05*ones(1,10).^2);          % Distortion

filename = 'z.dat';
%file_2   = 'output_data_1.txt';
%output   = importdata(filename);
IMU_data = importdata(filename);

% Simulated Variables
states  = [0 0 0 1 0 0 0 0 0 0]; % xv(k)
control = [0 0 0 0 0 0];         %  u(k)

% Estimated Variables
estimate = [0 0 0 1 0 0 0 0 0 0];      %\x(k) 
Px       = diag([1 1 1 1 1 1 1 1 1 1].^1);             % ?(k)

% Trajectories
delta_t = 0:dt:1.6;
pos_state = zeros(3, size(delta_t,2));
PP = zeros(10, size(delta_t,2));
est_pos = zeros(3, size(delta_t,2));
est_vel = zeros(3, size(delta_t,2));
outd = zeros(10, size(delta_t,2));

% Perturbation Levels
r = sqrt(diag(R));
q = sqrt(diag(Q));

i = 1;
for t = delta_t
    % Read IMU measurements to obtain the control data
    % IMU generates a measurement every 0.02 seconds - the same as the
    % system's sampling time:
    control = IMU_data(i,:);
    %
    % Simulate Actual Data:
    w      = r .* randn(6,1); 
    states = transition_f(states, control, w, dt);
    v      = q .* randn(10,1);
    out = states' + v;
    
    % Estimate
    [estimate, F_x, F_w] = transition_f(estimate, control, 0*randn(6,1),dt); 
    Rp = zeros(10,10);
    Rf = F_w*R*F_w';
    Rp(1:6,1:6) = Rf;
    Px = F_x*Px*F_x' + Rp;
    
    % Correction
    [e, H] = measure_f(estimate);
    E      = H *Px *H';
    
    z = out - e';
    Z = Q + E;
    
    %Z = 0.5*(Z+Z');
    K = Px *H' *Z^-1;
    
    estimate = estimate + (K*z)';
    Px       = Px - K *H *Px;
    
    % Data Collection
    out = out';
%     pos_state(1,i) = states(1); 
%     pos_state(2,i) = states(2);
%     pos_state(3,i) = states(3);

    [pos_state(1,i) pos_state(2,i) pos_state(3,i)] = quat2angle([states(4) states(5) states(6) states(7)]);
%     est_pos(1,i) = estimate(4);
%     est_pos(2,i) = estimate(5);
%     est_pos(3,i) = estimate(6);
%     est_pos(4,i) = estimate(7);

%     est_pos(1,i) = estimate(1);
%     est_pos(2,i) = estimate(2);
%     est_pos(3,i) = estimate(3);
    outd(1,i) = out(1);
    outd(2,i) = out(2);
    outd(3,i) = out(3);
    PP(1,:)   = Px(1,1);
    %control = [0 0 0 0 0 0];
    i = i+1;
    
%     plot3(pos_state(1,i), pos_state(2,i), pos_state(3,i), 'r')
%     axis([0 100 0 10 0 10])
%     hold on
%     pause(0.5)
%     drawnow 
%     
%     plot3(states(1),states(2), states(3), '*r')
%     %plot(X(1),X(2),'*r')
%     axis([0 100 0 10 0 10])
%     hold on
%     %
%     pause(0.5)
%     drawnow
end

%D_x = output(:,1);
%D_y = output(:,2);
%D_z = output(:,3);

figure(1) 
hold on
plot(pos_state(1,:), '--r')
plot(pos_state(2,:), '--b')
plot(pos_state(3,:), '--g')
%plot(D_x, '-ok')
legend('truth','estimate','measurement', 'Davison Sim')
xlabel('sample no.')
ylabel('x-position')
hold off
% figure(1) 
% hold on
% plot(pos_state(1,:), '*r')
% plot(est_pos(1,:), '--b')
% plot(outd(1,:), 'g')
% %plot(D_x, '-ok')
% legend('truth','estimate','measurement', 'Davison Sim')
% xlabel('ssmple no.')
% ylabel('x-position')
% hold off
% 
% figure(2) 
% hold on
% plot(pos_state(2,:), '*r')
% plot(est_pos(2,:), '--b')
% plot(outd(2,:), 'g')
% %plot(D_y, '-ok')
% legend('truth','estimate','measurement', 'Davison Sim')
% xlabel('ssmple no.')
% ylabel('y-position')
% hold off
% 
% figure(3) 
% hold on
% plot(pos_state(3,:), '*r')
% plot(est_pos(3,:), '--b')
% plot(outd(3,:), 'g')
% %plot(D_z, '-ok')
% legend('truth','estimate','measurement', 'Davison Sim')
% xlabel('ssmple no.')
% ylabel('z-position')
% hold off
% 
% figure(4)
% hold on
% title('Trajectory of the robot')
% plot3(pos_state(1,:), pos_state(2,:), pos_state(3,:),'g--o')
% plot3(est_pos(1,:), est_pos(2,:), est_pos(3,:), 'b--o')
% %plot3(D_x,D_y,D_z, 'k--o')
% xlabel('x-position')
% legend('truth','estimate','Davison Sim')
% ylabel('y-position')
% zlabel('z-position')
% grid on
% hold off

% %  figure(4)
% %  hold on
% %  plot3(pos_state(1,:), pos_state(2,:), pos_state(3,:))
% %  plot3(est_pos(1,:), est_pos(2,:), est_pos(3,:))
% %  grid on
% %  hold off    