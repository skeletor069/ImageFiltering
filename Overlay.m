function Overlay( image, Mc )
overlay = image;
overlay(:,:,1) = Mc*255;
figure('name', 'Overlay of original image and corner mask', 'NumberTitle','off');
subplot(1,2,1);
imshow(image); title('Original Image');
subplot(1,2,2);
imshow(overlay);title('Overlay');
end

