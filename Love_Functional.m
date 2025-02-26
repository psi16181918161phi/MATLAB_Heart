% MATLAB script to plot letters L, O, V, E using parametric equations without titles

figure;

%% Letter L
subplot(4,1,1);
hold on;
t = linspace(0,1,100);
% Vertical segment: x = 0, y = t
plot(zeros(size(t)), t, 'r', 'LineWidth', 2);
% Horizontal segment: x = t, y = 0
plot(t, zeros(size(t)), 'r', 'LineWidth', 2);
hold off;
axis equal;
axis off;

%% Letter O
subplot(4,1,2);
t = linspace(0, 2*pi, 200);
x = cos(t);
y = sin(t);
plot(x, y, 'r', 'LineWidth', 2);
axis equal;
axis off;

%% Letter V
subplot(4,1,3);
hold on;
t = linspace(0,1,100);
% Left branch: from (-1,1) to (0,0)
x_left = -1 + t;
y_left = 1 - t;
plot(x_left, y_left, 'r', 'LineWidth', 2);
% Right branch: from (1,1) to (0,0)
x_right = 1 - t;
y_right = 1 - t;
plot(x_right, y_right, 'r', 'LineWidth', 2);
hold off;
axis equal;
axis off;

%% Letter E
subplot(4,1,4);
hold on;
t = linspace(0,1,100);
% Vertical line: x = 0, y in [0,1]
plot(zeros(size(t)), t, 'r', 'LineWidth', 2);
% Top horizontal line: y = 1, x in [0,1]
plot(t, ones(size(t)), 'r', 'LineWidth', 2);
% Middle horizontal line: y = 0.5, x in [0,0.8]
plot(linspace(0,0.8,100), 0.5*ones(1,100), 'r', 'LineWidth', 2);
% Bottom horizontal line: y = 0, x in [0,1]
plot(t, zeros(size(t)), 'r', 'LineWidth', 2);
hold off;
axis equal;
axis off;
