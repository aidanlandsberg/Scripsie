function [ q_C ] = axis2quat_f( omega_C, dt )
% This function calculates a quarternion from the current angle axis
% rotation
% Convert Raw Gyro Data:
% axis2quat = {
% gyroRate  = (omegaX omegaY omegaZ) = omegaC
% qdotC     = (qdot0 qdot1 qdot2 qdot3)'
% 
% omegaC    = gyroRate*dt
% omegaNorm = sqrt(rateX^2*dt rateY^2*dt rateZ^2*dt)
% angle_axis= 
%
% q0 = cos(omegaNorm/2) 
% q1 = (omegax/omegaNorm)*sin(omegaNorm/2)
% q2 = (omegay/omegaNorm)*sin(omegaNorm/2)
% q3 = (omegaz/omegaNorm)*sin(omegaNorm/2)
% q  = (q0 q1 q2 q3)' 

omega_norm = norm(omega_C*dt);

  q_C(1) = cos(omega_norm/2);
  q_C(2) = (omega_C(1)*dt/omega_norm)*sin(omega_norm/2);
  q_C(3) = (omega_C(2)*dt/omega_norm)*sin(omega_norm/2);
  q_C(4) = (omega_C(3)*dt/omega_norm)*sin(omega_norm/2);

  q_C = [q_C(1) q_C(2) q_C(3) q_C(4)];
  
  q_norm = norm(q_C);
  
  if q_norm ~= 0;
    q_C = q_C/q_norm;
  end

end

