function [  ] = Magnitude( I_x, I_y )
G = sqrt(I_x .^2 + I_y .^2);

figure('name', 'Magnitude', 'NumberTitle','off');
imshow(G);
title('G')

end

