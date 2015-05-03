% Kalman Filter Example
% 
% 1. System
%
%   x(k+1) = F_x *x + F_u *u + F_n *n
%   y      = H *x + v
%
%   x: state vector             - P: cov. matrix
%   u: control vector
%   n: perturbation vector      - Q: cov. matrix
%   y: measurement vector       
%   v: measurement noise        - R: cov. matrix
%
%   F_x: transition matrix
%   F_u: control matrix
%   F_n: pert. matrix
%   H  : measurement matrix
%
% 2. Initialization
%
%   Define F_x, F_u, F_n and H
%
%   Precise x, P, Q and R
%
% 3. Temporal loop.
%   3a) Prediction (mean value) when arrival of u
%       
%       x(k+1) = F_x *x + F_u *u (+F_n *0)
%       P(k+1) = F_x *P *F_x' + F_n *Q *F_n' 
%
%   3b) Correction arrival at y
%       
%       e = H *x (+0)
%       E = H *P *H'    -cov. matrix
%
%       z = y - e
%       Z = R + E
%
%       K = P *H' *Z^-1 - Kalman Gain
%       
%  x(k+1) = x + K*z
%
%  P(k+1) = P - K *H *P // P - K *Z *K'
%
% 4. Plot Results  
%
% 5. How to set up KF examples
%   5.1 Simulate a system, get x, u and y trajectories
%
%   5.2 Estimate x with the KF. Get x and P trajectories
%
%   5.3 Plot results 
%
%
%       