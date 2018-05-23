function [ GoG_x, GoG_y ] = GoG(sigma, radius)


cx = meshgrid(-radius:radius, -radius:radius);
cy = cx';

GoG_x = zeros(2*radius+1);

for i=1:2*radius+1
    for j=1:2*radius+1
       GoG_x(i,j) =  (-cx(i,j)/(2*pi*sigma^4))*exp(-(cx(i,j)^2+cy(i,j)^2)/(2*sigma^2));
    end
end

GoG_y=GoG_x';
end

