function [ W, Q ] = CornernessRoundness( I_x, I_y )

dimension = size(I_x);
wN = ones(5);
k = 2;
Q = zeros(dimension);
W = zeros(dimension);

for i=k+1:dimension(1)-k
    for j = k+1:dimension(2)-k
        Ix = I_x(i-k:i+k , j-k:j+k);
        Iy = I_y(i-k:i+k , j-k:j+k);
        Ix2 = Ix .^2 .* wN;
        Iy2 = Iy .^2 .* wN;
        Ixy = Iy .* Ix .* wN;
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

