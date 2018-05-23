function [ I_x, I_y ] = Filtering( img, radius, GoG_x, GoG_y )
dimension = size(img);

I_x = zeros(dimension);
for i = radius+1:dimension(1)-radius
    for j=radius+1:dimension(2)-radius
        input = img(i-radius:i+radius , j-radius:j+radius);
        output = input .* GoG_x;
        I_x(i,j) = sum(sum(output));
    end
end

I_y = zeros(dimension);
for i = radius+1:dimension(1)-radius
    for j=radius+1:dimension(2)-radius
        input = img(i-radius:i+radius , j-radius:j+radius);
        output = input .* GoG_y;
        I_y(i,j) = sum(sum(output));
    end
end

figure('name', 'GoG Filtering', 'NumberTitle','off');
subplot(1,3,1);
imshow(img); title('Source (grayscaled)');
subplot(1,3,2);
imshow(I_x,[]); title('I_x');
subplot(1,3,3);
imshow(I_y,[]); title('I_y');
end

