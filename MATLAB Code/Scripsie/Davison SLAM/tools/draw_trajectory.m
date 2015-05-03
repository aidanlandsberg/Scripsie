function draw_trajectory (trajectory, color, step)
%-------------------------------------------------------
% University of Zaragoza
% Centro Politecnico Superior
% Robotics and Real Time Group
% Authors:  J. Neira, J. Tardos
% Date   :  7-2004
%-------------------------------------------------------
%-------------------------------------------------------
global configuration;

%draw locations
if nargin == 3
    loc = [trajectory(1:step).x];
else
    loc = [trajectory(:).x];
end

x = loc(1,:)';
y = loc(2,:)';
plot(x, y, [color '-']);

for p = 1:length(x),
    if configuration.ellipses
        draw_ellipse (trajectory(p).x, trajectory(p).P, color);
    end
   draw_vehicle(trajectory(p).x, trajectory(1).P, color);
end
