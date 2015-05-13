close all
clear all 

filename = '7.dat';

data = importdata(filename, ';');

%reduced_data = data(:,2:9);
%reduced_data = data(:,2:9);
accx = data(:,1);
accy = data(:,2);
accz = data(:,3); 

meanx = mean(data(:,1))
meany = mean(data(:,2))
meanz = mean(data(:,3))

wx = data(:,4);
wy = data(:,5);
wz = data(:,6);

mx = mean(wx)
my = mean(wy)
mz = mean(wz)

varax = var(accx)
varay = var(accy)
varaz = var(accz)

vargx = var(wx)
vargy = var(wy)
vargz = var(wz)

n = linspace(1,length(accx),length(accx));

%mean_ax(1:n) = meanx;
%mean_ay(1:n) = meany;
%mean_az(1:n) = meanz;

%mean_wx(1:n) = mx;
%mean_wy(1:n) = my;
%mean_wz(1:n) = mz;

figure
hold on
title('Accelerometer Z-Axis Calibration Samples')
plot(n,accx, 'r')
plot(n,accy, 'b')
plot(n,accz, 'k')
plot(n, meanx*ones(size(n)), 'g')
plot(n, meany*ones(size(n)), 'c')
plot(n, meanz*ones(size(n)), 'y')
xlabel('samples')
ylabel('meteres per second squared (m/s^2)')
legend('x-bias','y-bias','z-bias','x-mean','y-mean','z-mean');
hold off

figure
hold on
title('Gyroscope Calibration Samples')
plot(n, wx, 'b')
plot(n, wy, 'r')
plot(n, wz, 'k')
plot(n, mx*ones(size(n)), 'g')
plot(n, my*ones(size(n)), 'c')
plot(n, mz*ones(size(n)), 'y')
xlabel('samples')
ylabel('degrees per second (\circ/s)')
legend('x-bias','y-bias','z-bias','x-mean','y-mean','z-mean');
hold off

% figure
% hold on
% title('Accelerometer noise variance')
% plot(n, varx, 'b')
% plot(n, vary, 'r')
% plot(n, varz, 'k')
% %legend('x-variance','y-variance','z-variance');
% hold off