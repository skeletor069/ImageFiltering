clc
clear
 
name= 'input_sat_image.jpg'

%% Task A
%Imean_strch = TaskA(name);
image =  imread(name);
img = enhance(image);
figure('Name', 'Cornerness and Roundness', 'NumberTitle', 'off');
subplot(3,3,1);
imshow(img);
title('Input Image');

 
%% GoG image filtering 
%% GoG filter
sigma = 0.5;    

% radius of filter kernel
radius = round(3*sigma);

cx = meshgrid(-radius:radius, -radius:radius);
cy = cx';

GoG_x = zeros(2*radius+1);

for i=1:2*radius+1
    for j=1:2*radius+1
       GoG_x(i,j) =  (-cx(i,j)/(2*pi*sigma^4))*exp(-(cx(i,j)^2+cy(i,j)^2)/(2*sigma^2));
    end
end

GoG_y=GoG_x';
dims = size(img);

filtered_x = zeros(dims);
for i = radius+1:dims(1)-radius
    for j=radius+1:dims(2)-radius
        input = img(i-radius:i+radius , j-radius:j+radius);
        input = input .* GoG_x;
        filtered_x(i,j) = sum(sum(input));
    end
end
subplot(3,3,2);
imshow(filtered_x,[]);
title('Ix');

filtered_y = zeros(dims);
for i = radius+1:dims(1)-radius
    for j=radius+1:dims(2)-radius
        input = img(i-radius:i+radius , j-radius:j+radius);
        input = input .* GoG_y;
        filtered_y(i,j) = sum(sum(input));
    end
end
subplot(3,3,3);
imshow(filtered_y,[]);
title('Iy');


G = sqrt(filtered_x .^2 + filtered_y .^2);

subplot(3,3,4);
imshow(G);
title('G');


 

%% TaskB
w = ones(5);
wn = 2;

 autoCor = zeros(dims(1), dims(2),2,2);

roundness = zeros(dims);
cornerness = zeros(dims);
for i=wn+1:dims(1)-wn
    for j = wn+1:dims(2)-wn
        Ix = filtered_x(i-wn:i+wn , j-wn:j+wn);
        Iy = filtered_y(i-wn:i+wn , j-wn:j+wn);
        Ix2 = Ix .^2 .* w;
        Iy2 = Iy .^2 .* w;
        Ixy = Iy .* Ix .* w;
        M = [sum(sum(Ix2)) , sum(sum(Ixy)) ; sum(sum(Ixy)) , sum(sum(Iy2))];
        autoCor(i,j,:,:) = M;
        roundness(i,j) = 4* det(M) / max(0.0000000001 , (trace(M)^2));
        cornerness(i,j) = trace(M)/2 - sqrt((trace(M)/2)^2 - det(M));
    end
end

subplot(3,3,5);
imshow(roundness,[]);
colormap(pink);
title('Roundness');

subplot(3,3,6);
imshow(cornerness);
title('Cornerness');

mask = zeros(dims);
for i=1:dims(1)
    for j=1:dims(2)
        if cornerness(i,j) > 0.004 && roundness(i,j) > 0.5
            mask(i,j) = 1;
        end
    end
end

subplot(3,3,7);
imshow(mask);
title('Mask');


W = mask .* cornerness;
Q = mask .* roundness;
combined = W.*Q;
final = imregionalmax(combined);

subplot(3,3,8);
imshow(final);
title('Points of interest');

result = image;
result(:,:,1) = mask*255;
subplot(3,3,9);
imshow(result);
title('Result');


% % :)