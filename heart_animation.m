%% matlab heart animation 
clc; clear; close all;
x = -2:0.005:2; % Define x range
a = 0:5:1700; % Alpha values for animation
y = zeros(size(x));
%% plots 
figure;
h = plot(x, y, 'r', 'LineWidth', 2);
axis([-2 2 -2 3]);
grid on;
hold on;
%% animation 
for alpha = a
y = nthroot(x, 3).^2 + 0.9 * sin(alpha * pi * x) .* sqrt(4 - x.^2);
set(h, 'YData', y);
pause(0.5);
end