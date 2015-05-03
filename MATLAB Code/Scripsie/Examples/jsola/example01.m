%Define system
% x(k+1) = F*x(k) + g*u(k) + w(k)
% y      = I*x(k) + (0)*u(k) = v(k) 
dt = 1;

I = eye(13)
A = zeros(13,13);
A(1,4) = 1;
A(2,5) = 1;
A(3,6) = 1;

F = (I + A*dt)
g = diag(ones(10,1),0)*dt;
F_n = 0;
H = I;

Q = 0;
R = 0;

% Simulated variables

X = zeros(13,13);        %metres
u = zeros(10,10);        %metres/second

%estimated variables

x = [0 0 0 1 0 0 0 0 0 0 0 0 0]; 
P = 0;

%trajectories

tt = 0:dt:100;
XX = zeros(1, size(tt,2));
xx = zeros(1, size(tt,2));
yy = zeros(1, size(tt,2));
PP = zeros(1, size(tt,2));

% perturbation levels

q = sqrt(Q);
r = sqrt(R);

% start loop
i = 1;

for t = tt

    % simulate
    n = q * randn;
    X = F*tanspose(X) + g*transpose(u)  
    v = r * randn;
    y = H*X + v;
    
    %estimate
    x = F*x + g*u;
    P = F*P*x' + F*Q*F';
    
    % correction
    e = H *x;
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
end

Diff = XX - xx;

%plot
plot(tt,xx,tt,yy,tt,sqrt(PP),tt,XX);
legend('state','measurement','sigma', 'actualx', 'actualy');
