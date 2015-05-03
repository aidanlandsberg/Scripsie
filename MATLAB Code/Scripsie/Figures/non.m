close all
clc
clear all

x = [-5:.01:5];
X = normpdf(x,0,1);


y = x.^2 + 0;
%X1 = normpdf(y,0,2);

Y = chi2pdf(y,1);

z = ones(1,1000);
Z = linspace(0,1000,1000);
z0 = ones(1,1000);
Z0 = linspace(-5,1,1000);
Z1 = linspace(1,25,1000);
z1 = zeros(1,1000);
Z2 = linspace(0,0.425,1000);


subplot(2,2,1)
hold on
plot(Y, y,'b','LineWidth',2.005)
%plot(X1, y,'b','LineWidth',2.005)
plot(0,1,'om','LineWidth',1.5)
legend('Transformed pdf (f_y(y))','mean (\mu_y)', 'Location','southeast')
plot(Z, z0,'--k','LineWidth',1.5)
title('Transformed Gaussian PDF (Chi Squared (N=1))')
axis([-0.01 5.5 0 25])
xlabel('f_y(y)')
%view(-90, 90) % Swap the axes
set(gca, 'ydir', 'reverse')
hold off

t = heaviside(x);
y = t.*y;
subplot(2,2,2)
hold on
plot(x, y, 'r' ,'LineWidth',2.005)
plot(-5,1, 'om' ,'LineWidth',1.5)
plot(1,25,'*m','LineWidth',1.5)
legend('Non Linear Transform Function', 'mean (\mu_Y)','projected mean (\mu_x)' ,'Location','southwest')
plot(Z0, z0,'--k','LineWidth',1.5)
plot(z0, Z1,'--k','LineWidth',1.5)
title('Non Linear Transformation Function: y(X) = X^2')
axis([-5 5 0 25])
set(gca, 'ydir', 'reverse')
ylabel('y(x)')
hold off

subplot(2,2,4)
hold on
plot(x, X, 'LineWidth',2.005)
plot(0,0,'xm','LineWidth',1.5)
legend('Original Gaussian PDF (\mu_x = 0, \Sigma_X = 1)', 'mean (\mu_x)','Location','northeast')
plot(z1, Z2,'--k','LineWidth',1.5)
title('Standard Gaussian PDF (\mu_X = 0, \Sigma_X = 1)')
axis([-5 5 0 .5])
ylabel('f_x(X)')
hold off


