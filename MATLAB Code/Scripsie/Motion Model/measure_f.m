function [y, y_x] = measure_f(state)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Measurement Model:
% Non-Linear function h(mu_t,mu_t-1):
% 
% h(x+|x) = {
% For the time being - this model will simulate the state exactly:
% Used for simulation accuracy testing - should track an ideal model
% perfectly.
% }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = state;

if nargout > 1
   
    y_x = [...
 
[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0]
[ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
[ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0]
[ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]
[ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0]
[ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
[ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]
[ 0, 0, 0, 0, 0, 0, 0, 1, 0, 1]
[ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]];
end

end
%%
function f()
%%
syms rx ry rz q0 q1 q2 q3 vx vy vz real
x = [rx;ry;rz;q0;q1;q2;q3;vx;vy;vz];
y = measure_f(x);
y_x = jacobian(y,x)
end