function [ Imean_strch ] = enhance( I )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Imean = uint8(mean(I,3));

size_Imean = size(Imean);

Imean_d = im2double(Imean);

min_Imean = min(min(Imean_d));
max_Imean = max(max(Imean_d));
new_min_Imean = 0 ;
new_max_Imean = 1 ;

for i=1:size_Imean(1)
     for j=1:size_Imean(2)
     Imean_strch(i,j) = (Imean_d(i,j) - min_Imean) * (new_max_Imean - new_min_Imean)/(max_Imean - min_Imean) + new_min_Imean ; 
    end
end

end

