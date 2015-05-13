a_C = [0 0 0];
q   = [1 0 0 0];
omega = [0 pi/2 0];
delta_t = 1;

for t= 0:delta_t:10
    
    [a q_G] = remove_gravity(q, a_C, omega, delta_t)
    q = q_G;
end

%plot(a)