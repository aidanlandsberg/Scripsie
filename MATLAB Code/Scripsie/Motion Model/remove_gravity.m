function [anew] = remove_gravity(q, a_C, omega, delta_t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function seeks to remove the gravity vector from the IMU data: 
%
% f = R(a - g) - f=linear accell, R=rotation matrix, a=IMU meas, g=gravity
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
norm_omega = sqrt(omega(1)^2+omega(2)^2+omega(3)^2);

g = [0 0 9.81];    

if norm_omega == 0
    % Rotate the acceleration into the world frame 
        g_G = quatrotate_f(q,g);
        
    %Subtract the gravity vector
        anew(1) = a(1) - g_G(1);
        anew(2) = a(2) - g_G(2);
        anew(3) = a(3) - g_G(3);
else


ax = a_C(1);
ay = a_C(2);
az = a_C(3);

a = [ax ay az];
% Calculate orientation according to the angle axis rotation
q_C = axis2quat_f(omega,delta_t);
q_G = quatmultiply_f(q,q_C);
% Rotate the acceleration into the world frame 
g_G = quatrotate_f(q_G,g);

%Subtract the gravity vector
anew(1) = a(1) - g_G(1);
anew(2) = a(2) - g_G(2);
anew(3) = a(3) - g_G(3);

end
