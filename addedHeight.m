function [addedColorImage,addedEnergyImage] = addedHeight(img, energyImage,method)
[rows, columns]= size(energyImage);

if strcmp(method,'Backward')
    [cumulativeEnergyMap,from] = cumulative_minimum_energy_map(energyImage,'HORIZONTAL');
    seam = find_optimal_seam(cumulativeEnergyMap,from,'HORIZONTAL');
elseif strcmp(method,'Forward')
    [forward_energy,from] = forward_looking_energy(img,energyImage,'HORIZONTAL');
    seam = find_optimal_seam(forward_energy,from,'HORIZONTAL');
else
    fprintf('Error in addedHeight -> Method')
end
addedColorImage = zeros(rows+1,columns,3);
for i = 1:columns
    addedColorImage(1:seam(i)-1,i,:) = img(1:seam(i)-1,i,:);
    addedColorImage(seam(i)+1:rows+1,i,:) = img(seam(i):rows,i,:);
    if seam(i) > 1 && seam(i) < rows+1
        addedColorImage(seam(i),i,:) = 0.5*addedColorImage(seam(i)-1,i,:)+0.5*addedColorImage(seam(i)+1,i,:);
    end
    
end
addedColorImage = uint8(addedColorImage);
addedEnergyImage = energy_Image(addedColorImage);
end

