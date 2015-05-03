close all

filename = 'Data2.dat';

data = importdata(filename, '\t');

%reduced_data = data(:,2:9);
%reduced_data = data(:,2:9);
acc = data(:,2);
n = linspace(1,length(acc),length(acc));
%acca = acc(60:length(acc));
%n = linspace(1,length(acca),10*length(acca));

figure
hold on
plot(n, acc, 'b')
plot(n, mean(acc), 'r')
%plot(data(:,2), 'g')
%plot(data(:,3), 'r')
%plot(data(:,4), 'k')
%plot(data(:,5), 'y')
%plot(data(:,6), 'm')
%legend('Pitch (Complementary Filter)')
hold off