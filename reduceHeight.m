function [reducedColorImage,reducedEnergyImage] = reduceHeight(img, energyImage,method)
[rows,columns] = size(energyImage);

if strcmp(method,'Backward')
    [cumulativeEnergyMap,from] = cumulative_minimum_energy_map(energyImage,'HORIZONTAL');
    seam = find_optimal_seam(cumulativeEnergyMap,from,'HORIZONTAL');
elseif strcmp(method,'Forward')
    [forward_energy,from] = forward_looking_energy(img,energyImage,'HORIZONTAL');
    seam = find_optimal_seam(forward_energy,from,'HORIZONTAL');
else
    fprintf('Error in reduceHeight -> Method')
end
% displayseam(img,seam,'HORIZONTAL');
reducedColorImage = zeros(rows-1,columns,3);

for i = 1:columns
    reducedColorImage(1:seam(i)-1,i,:) =  img(1:seam(i)-1,i,:);
    reducedColorImage(seam(i):rows-1,i,:) = img(seam(i)+1:rows,i,:);
end
reducedColorImage = uint8(reducedColorImage);
reducedEnergyImage = energy_Image(reducedColorImage);

end