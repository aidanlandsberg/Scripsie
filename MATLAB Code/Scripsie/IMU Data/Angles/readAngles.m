close all

filename = 'flatData.dat';

data = importdata(filename);

%reduced_data = data(:,2:9);
%reduced_data = data(:,2:9);

figure
hold on
%plot(data(:,1), 'b')
%plot(data(:,2), 'g')
%plot(data(:,3), 'r')
%plot(data(:,4), 'k')
%plot(data(:,5), 'y')
%plot(data(:,6), 'm')
%legend('Pitch (Complementary Filter)')
hold off

% figure
% hold on
% %plot(reduced_data(:,5), 'b')
% %plot(reduced_data(:,6), 'g')
% plot(reduced_data(:,7), 'r')
% %plot(reduced_data(:,8), 'k')
% legend('Roll (Complementary Filter)')
% hold off
