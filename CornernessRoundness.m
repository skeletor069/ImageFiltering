function [ W, Q ] = CornernessRoundness( I_x, I_y )

dimension = size(I_x);
w = ones(5);
wn = 2;
Q = zeros(dimension);
W = zeros(dimension);

for i=wn+1:dimension(1)-wn
    for j = wn+1:dimension(2)-wn
        Ix = I_x(i-wn:i+wn , j-wn:j+wn);
        Iy = I_y(i-wn:i+wn , j-wn:j+wn);
        Ix2 = Ix .^2 .* w;
        Iy2 = Iy .^2 .* w;
        Ixy = Iy .* Ix .* w;
        M = [sum(sum(Ix2)) , sum(sum(Ixy)) ; sum(sum(Ixy)) , sum(sum(Iy2))];
        Q(i,j) = 4* det(M) / (trace(M)^2);
        W(i,j) = trace(M)/2 - sqrt((trace(M)/2)^2 - det(M));
    end
end

figure('name', 'Cornerness and Roundness', 'NumberTitle','off');
subplot(1,2,1);
imshow(W);
title('Cornerness');

subplot(1,2,2);
imshow(Q,[]);
title('Roundness');
colormap(jet);

end

