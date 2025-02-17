clc; clear; close all;

% Create figure
fig = figure('Color', [1 1 1]);

% Define parametric variables
[u, v] = meshgrid(linspace(0, pi, 60), linspace(0, 2*pi, 60));

% Function to generate heart shape
generateHeart = @(scale, stretch, roundness) deal(...
    16 * sin(u).^3 .* cos(v) * scale, ...
    (13 * cos(u) - 5 * cos(2*u) - 2 * cos(3*u) - cos(4*u)) * stretch, ...
    (16 * sin(u).^3 .* sin(v) - 5) * roundness ...
);

% Initial parameters
scale = 1; 
stretch = 1; 
roundness = 1;
colorShift = 0.5; % Initial color intensity

% Generate initial heart shape
[x, y, z] = generateHeart(scale, stretch, roundness);
h = surf(x, y, z, 'EdgeColor', 'none');

% Gradient Colormap (Smooth from Rose Gold → Pink → Purple → Violet)
customColormap = [ 
    0.98 0.76 0.71  % Rose Gold
    1.00 0.41 0.71  % Pink
    0.73 0.33 0.83  % Purple
    0.58 0.00 0.83  % Violet
];
colormap(customColormap);
shading interp;

% **Key Fix: Use Z-Data for Color Gradient Mapping**
h.FaceColor = 'interp';
h.FaceLighting = 'gouraud';  % Smooth shading
h.CData = z;                 % Map colormap to Z-values
caxis([min(z(:)) max(z(:))]); % Scale colormap properly

% Improved Lighting
light('Position', [1 1 2], 'Style', 'infinite');
light('Position', [-1 -1 2], 'Style', 'infinite');
lighting gouraud;
material shiny;

% Adjust axis & camera
axis equal;
view([30, 30]);
rotate3d on;

% UI Sliders for Shape Adjustments
handles.scaleSlider = uicontrol('Style', 'slider', 'Min', 0.5, 'Max', 2, 'Value', scale, ...
    'Position', [20 350 120 20], 'Callback', @(src, event) updateHeart());
uicontrol('Style', 'text', 'Position', [20 370 100 20], 'String', 'Scale');

handles.stretchSlider = uicontrol('Style', 'slider', 'Min', 0.8, 'Max', 1.5, 'Value', stretch, ...
    'Position', [20 300 120 20], 'Callback', @(src, event) updateHeart());
uicontrol('Style', 'text', 'Position', [20 320 100 20], 'String', 'Stretch');

handles.roundnessSlider = uicontrol('Style', 'slider', 'Min', 0.8, 'Max', 1.5, 'Value', roundness, ...
    'Position', [20 250 120 20], 'Callback', @(src, event) updateHeart());
uicontrol('Style', 'text', 'Position', [20 270 100 20], 'String', 'Roundness');

% UI Slider for Color Adjustments
handles.colorSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 1, 'Value', colorShift, ...
    'Position', [20 200 120 20], 'Callback', @(src, event) updateColor());
uicontrol('Style', 'text', 'Position', [20 220 100 20], 'String', 'Color Tone');

% Store handles for updating function
handles.h = h;
handles.generateHeart = generateHeart;
handles.customColormap = customColormap;
guidata(fig, handles);

% Function to update heart dynamically
function updateHeart()
    handles = guidata(gcf);
    scale = get(handles.scaleSlider, 'Value');
    stretch = get(handles.stretchSlider, 'Value');
    roundness = get(handles.roundnessSlider, 'Value');

    [x, y, z] = handles.generateHeart(scale, stretch, roundness);
    set(handles.h, 'XData', x, 'YData', y, 'ZData', z);

    % **Update color gradient dynamically**
    handles.h.CData = z;
    caxis([min(z(:)) max(z(:))]);

    drawnow;
end

% Function to update colormap dynamically
function updateColor()
    handles = guidata(gcf);
    colorShift = get(handles.colorSlider, 'Value');

    % Interpolate within the custom colormap for smooth transition
    adjustedColormap = handles.customColormap * (0.5 + colorShift);
    colormap(adjustedColormap);
    drawnow;
end
