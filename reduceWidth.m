function [reducedColorImage,reducedEnergyImage] = reduceWidth(img, energyImage,method)
[rows,columns] = size(energyImage);

if strcmp(method,'Backward')
    [cumulativeEnergyMap,from] = cumulative_minimum_energy_map(energyImage,'VERTICAL');
    seam = find_optimal_seam(cumulativeEnergyMap,from,'VERTICAL');
elseif strcmp(method,'Forward')
    [forward_energy,from] = forward_looking_energy(img,energyImage,'VERTICAL');
    seam = find_optimal_seam(forward_energy,from,'VERTICAL');
else
    fprintf("Error in addedWidth -> Method");
end

% displayseam(img,seam,'VERTICAL');
reducedColorImage = zeros(rows,columns-1,3);

for j = 1:rows
    reducedColorImage(j, 1:seam(j)-1, :) = img(j, 1:seam(j) - 1, :);
    reducedColorImage(j, seam(j):columns-1, :) = img(j, seam(j) + 1:columns,:);
    
end
reducedColorImage = uint8(reducedColorImage);
reducedEnergyImage = energy_Image(reducedColorImage);
end