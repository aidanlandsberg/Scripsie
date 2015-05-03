%Define system
%
% x = [px py vx vy]';
% y = [d a]';
% 
% u = [ax ay]';
% n = [nx ny]';
% r = [rd ra]';
% 
% px(k+1) = px + vx*dt;
% py(k+1) = py + vy*dt;
% vx(k+1)  = vx + ax*dt + nx;
% vy(k+1)  = vy + ay*dt + ny;
% 
% d = sqrt(px^2 + py^2) + rd;
% a = atan2(py, px) + ra;




dt = 0.1;

Q = diag([0.01 0.01].^2);
R = diag([0.01 1*pi/180].^2);

% Simulated variables

X = [2 1 -1 1]';        %metres
u = [0 0]';          %metres/second

%estimated variables

x = [3 3 0 0]'; 
P = diag([1 1 1 1].^2);

%trajectories

tt = 0:dt:4;
XX = zeros(4, size(tt,2));
xx = zeros(4, size(tt,2));
yy = zeros(2, size(tt,2));
PP = zeros(4, size(tt,2));

% perturbation levels

q = sqrt(diag(Q));
r = sqrt(diag(R));

% start loop
i = 1;
cla
for t = tt
    switch t
        case 1
            u = [2 0]'/dt;
        case 2
            u = [-3 0]'/dt;
        case 3
            u = [1 2]'/dt;
        otherwise
            u = [0 0]'/dt;   
    end
    
    % simulate
    n = q .* randn(2,1);
    X = example02_f(X,u,n,dt);
    v = r .* randn(2,1);
    y = example02_h(X) + v;
    
    %estimate
    [x, F_x, F_u, F_n] = example02_f(x,u,zeros(2,1),dt);
    P = F_x*P*F_x' + F_n*Q*F_n';
    
    % correction
    [e, H] = example02_h(x)
    E = H *P *H';
    
    z = y - e;
    Z = R + E;
    
    K = P *H' *Z^-1;
    
    x = x + K*z;
    P = P - K *H *P;
    
    % collect data
    XX(:,i) = X;
    xx(:,i) = x;
    yy(:,i) = y;
    PP(:,i) = diag(P);
    i = i+1;
    
    %plots
    
    plot(X(1),X(2),'*r')
    axis([-2 4 0 6])
    hold on
    plot(x(1),x(2),'*b')
    hold off
    %hold off
    pause(0.5)
    drawnow
end

% Diff = XX - xx;
% 
% plot
% plot(tt,xx,tt,yy,tt,sqrt(PP),tt,XX);
% legend('estimate','measurement','sigma', 'actualx', 'actualy');