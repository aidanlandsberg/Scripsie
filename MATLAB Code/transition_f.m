function [X, X_x, X_w] = transition_f(state, control, w, dt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% Sate Transition Model:
% Non-Linear function g(mu_t,mu_t-1):
% 
% g(x+|x,u) = {
% rW        = (x y z)' + R*rdotC*dt
% qWC       = (q0 q1 q2 q3)' xx quat(qdotC*dt)
% rdotW     = (xdot ydot zdot)' + R*rdotdotC*dt
% }
%
% Control Vector:
% U(x)      = {
% rdotdotC  = (xdotdot ydotdot zdotdot)'
% omegaC    = (omegax omegay omegaz)'
% }
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%STATES
rx = state(1);
ry = state(2);
rz = state(3);
q0 = state(4);
q1 = state(5);
q2 = state(6);
q3 = state(7);
vx = state(8);
vy = state(9);
vz = state(10);
%CONTROLS
ax = control(1) + w(1);
ay = control(2) + w(2);
az = control(3) + w(3);
omegaX = control(4) + w(4);
omegaY = control(5) + w(5);
omegaZ = control(6) + w(6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Need to transfer all data to the world frame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Declarations
 q_W = [q0 q1 q2 q3];
 % Convert to unit quarternion
 if norm(q_W) ~= 0
     q_W = q_W/norm(q_W);
     q_C = q_W;
 end
 
 a_C = [ax ay az];
 v_W = [vx vy vz];
 omega = [omegaX omegaY omegaZ];
 
 if norm(omega) == 0
     q = q_W;
     a_W = a_C;
     v_W = v_W + a_W*dt;

 else
     q_C = axis2quat_f(omega,dt);
     % Updates
     q = quatmultiply_f(q_W,q_C);
     a_W = quatrotate_f(q,a_C);
     v_W = v_W + a_W'*dt;
 end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Positional Transition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rx = rx + v_W(1)*dt;
ry = ry + v_W(2)*dt;
rz = rz + v_W(3)*dt;

X = [rx ry rz q(1) q(2) q(3) q(4) v_W(1) v_W(2) v_W(3)];
if nargout > 1
    X_x = [...
        [ 1, 0, 0, 0, 0, 0, 0, dt, 0, 0]
        [ 0, 1, 0, 0, 0, 0, 0, 0, dt, 0]
        [ 0, 0, 1, 0, 0, 0, 0, 0, 0, dt]
        [ 0, 0, 0, q_C(1), -q_C(2), -q_C(3), -q_C(4), 0, 0, 0]
        [ 0, 0, 0, q_C(2),  q_C(1), -q_C(4),  q_C(3), 0, 0, 0]
        [ 0, 0, 0, q_C(3),  q_C(4),  q_C(1), -q_C(2), 0, 0, 0]
        [ 0, 0, 0, q_C(4), -q_C(3),  q_C(2),  q_C(1), 0, 0, 0]
        [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 1]
        [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
        [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 1]];
    
    X_w = [...
        [ 1, 0, 0, 0, 0, 0]
        [ 0, 1, 0, 0, 0, 0]
        [ 0, 0, 1, 0, 0, 0]
        [ 0, 0, 0, 1, 0, 0]
        [ 0, 0, 0, 0, 1, 0]
        [ 0, 0, 0, 0, 0, 1]]; 
end
