close all
clc

x = [-5:.01:5];
X = normpdf(x,0,1);

y = 3.*x + 1; 
Y = normpdf(y,1,3);

z = X(1)*ones(1,1000);
Z = linspace(0,1000,1000);
z0 = ones(1,1000);
Z0 = linspace(-14,0,1000);
Z1 = linspace(-14,1,1000);
z1 = zeros(1,1000);
Z2 = linspace(0,0.425,1000);


subplot(2,2,1)
hold on
plot(Y, y,'b','LineWidth',2.005)
plot(0,1,'om','LineWidth',1.5)
plot(Z, z0,'--k','LineWidth',1.5)
legend('Transformed pdf (f_y(y))','mean (\mu_y)')
title('Transformed Gaussian PDF (\mu_Y = 3\mu_X + 1, \Sigma_Y = 3\Sigma_X)')
axis([0 0.14 -14 16])
xlabel('f_y(y)')
hold off

subplot(2,2,2)
hold on
plot(x, y, 'r' ,'LineWidth',2.005)
plot(-5,1,'om','LineWidth',1.5)
plot(0,-14,'xm','LineWidth',1.05)
legend('Linear Transform Function','mean (\mu_y)','mean (\mu_x)')
plot(Z0, z0,'--k','LineWidth',1.5)
plot(z1, Z1,'--k','LineWidth',1.5)
title('Linear Transformation Function: y(x) = 3x+1')
axis([-5 5 -14 16])

ylabel('y(x)')
hold off

subplot(2,2,4)
hold on
plot(x, X, 'LineWidth',2.005)
plot(0,0,'xm','LineWidth',1.05)
legend('Original Gaussian PDF (\mu_x = 0, \Sigma_X = 1)', 'mean (\mu_x)','Location','northeast')
plot(z1, Z2,'--k','LineWidth',1.5)
title('Standard Gaussian PDF (\mu_X = 0, \Sigma_X = 1)')
axis([-5 5 0 .5])
ylabel('f_x(X)')
hold off


