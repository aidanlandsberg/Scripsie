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

dt = 1/30;                          % Sampling time ?T
R = diag(ones(1,6).^2);         % Accell and Gyro Noise  
Q = diag(ones(1,10).^2);                 % Distortion

% Simulated Variables
states  = [5 5 5 1/sqrt(2) 0 0 1/sqrt(2) 0 1 0]; % xv(k)
control = [1 0 1 3 0.4 0.22];                         %  u(k)

% Estimated Variables
estimate = [3 3 3 1/sqrt(2) 0 0 1/sqrt(2) 0 0 0];      % \x(k) 
Px       = diag([1 1 1 1 1 1 1 1 1 1].^1);             % ?(k)

% Trajectories
delta_t = 0:dt:3;
pos_state = zeros(3, size(delta_t,2));
PP = zeros(10, size(delta_t,2));
est_pos = zeros(3, size(delta_t,2));
est_vel = zeros(3, size(delta_t,2));
outd = zeros(10, size(delta_t,2));

% Perturbation Levels
r = 0;%sqrt(diag(R));
q = 0;%sqrt(diag(Q));

i = 1;
for t = delta_t
%     switch t
%         case 1/10
%             control = [1 0 0 0 0 0];
%         case 2/10
%             control = [0 1 0 3 0 0];
%         case 1
%             control = [0 0 1 0 0 1];
%         otherwise
%             control = control;   
%     end

    % Simulate Actual Data:
    w      = r .* randn(6,1); 
    states = transition_f(states, control, w, dt);
    v      = q .* randn(10,1);
    out = measure_f(states)' + v;
    
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
    pos_state(1,i) = states(1); 
    pos_state(2,i) = states(2);
    pos_state(3,i) = states(3);
    
    est_pos(1,i) = estimate(1);
    est_pos(2,i) = estimate(2);
    est_pos(3,i) = estimate(3);
%     outd(1,i) = out(1,i);
%     outd(2,i) = out(2,i);
%     outd(3,i) = out(3,i);
    
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

figure 
hold on
plot(pos_state(1,:), '*r')
plot(est_pos(1,:), 'b')
hold off

figure 
hold on
plot(pos_state(2,:), '*r')
plot(est_pos(2,:), 'b')
hold off

figure 
hold on
plot(pos_state(3,:), '*r')
plot(est_pos(3,:), 'b')
hold off

% figure
% hold on
% plot3(pos_state(1,:), pos_state(2,:), pos_state(3,:))
% plot3(est_pos(1,:), est_pos(2,:), est_pos(3,:))
% grid on
% holf off


 
    