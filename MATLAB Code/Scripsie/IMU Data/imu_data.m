%-------------------------------------------------------------------------
% This script calculates the noise pertubation levels from static IMU_data
%-------------------------------------------------------------------------
close all
clear all

filename = 'flatData.dat';

N = importdata(filename);

%Split data accordingly
Accel = N(:,1:3);
Gyro  = N(:,4:6);

%Calculate means (Acceleration)
mean_acc_x = mean(Accel(:,1));
mean_acc_y = mean(Accel(:,2));
mean_acc_z = mean(Accel(:,3));

%Calculate means (Angular Rates)
mean_gyro_x = mean(Gyro(:,1));
mean_gyro_y = mean(Gyro(:,2));
mean_gyro_z = mean(Gyro(:,3));

%Calculate Variance (Acceleration)
sigma_acc_x = var(Accel(:,1));
sigma_acc_y = var(Accel(:,2));
sigma_acc_z = var(Accel(:,3));

%Calculate variance (Angular Rates)
sigma_gyro_x = var(Gyro(:,1));
sigma_gyro_y = var(Gyro(:,2));
sigma_gyro_z = var(Gyro(:,3));

%Plot the raw data
figure
hold on
plot(Accel(:,1), 'r');
plot(Accel(:,2), 'b')
plot(Accel(:,3), 'g')
hold off

figure
hold on
plot(Gyro(:,1), 'r');
plot(Gyro(:,2), 'b')
plot(Gyro(:,3), 'g')
axis([0 8955 -1 1])
hold off

%Print the statistical properties
mean_acc_x
mean_acc_y
mean_acc_z

sigma_acc_x
sigma_acc_y
sigma_acc_z

mean_gyro_x
mean_gyro_y
mean_gyro_z

sigma_gyro_x
sigma_gyro_y
sigma_gyro_z