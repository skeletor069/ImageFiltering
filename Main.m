%% Exercise 2
% Darpan Vats - 119188
% Mohammad Izabul Khaled - 119013
% Tanveer Al Jami - 119118

%% Task A

image = imread('test.png');
img = rgb2gray(image);
img = im2double(img);

sigma = 0.5;    
radius = round(3*sigma);

% Calculating the kernels
[GoG_x, GoG_y] = GoG(sigma, radius);
% Applying the filter to the image
[I_x, I_y] = Filtering(img, radius, GoG_x, GoG_y);
% Calculating magnitude of filtered images
Magnitude(I_x, I_y);


%% Task B

% Calculate cornerness and roundness
[W,Q] = CornernessRoundness(I_x, I_y);
% Obtain corner point candidates
Mc = CornerPoints(W,Q);
% Overlay of original and mask
Overlay(image, Mc);
