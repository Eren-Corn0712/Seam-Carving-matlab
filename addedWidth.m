function [addedColorImage,addedEnergyImage] = addedWidth(img, energyImage,method)
[rows, columns]= size(energyImage);

if strcmp(method,'Backward')
    [cumulativeEnergyMap,from] = cumulative_minimum_energy_map(energyImage,'VERTICAL');
    seam = find_optimal_seam(cumulativeEnergyMap,from,'VERTICAL');
elseif strcmp(method,'Forward')
    [forward_energy,from] = forward_looking_energy(img,energyImage,'VERTICAL');
    seam = find_optimal_seam(forward_energy,from,'VERTICAL');
else
    fprintf("Error in addedWidth -> Method");
end

addedColorImage = zeros(rows,columns+1,3);
for j = 1:rows
    addedColorImage(j,1:seam(j)-1,:) = img(j,1:seam(j)-1,:);
    addedColorImage(j,seam(j)+1:columns+1,:) = img(j,seam(j):columns,:);
    if seam(j) > 1 && seam(j) < columns+1
        addedColorImage(j,seam(j),:) = 0.5*addedColorImage(j,seam(j)-1,:)+0.5*addedColorImage(j,seam(j)+1,:);
    end
    
end
addedColorImage = uint8(addedColorImage);
addedEnergyImage = energy_Image(addedColorImage);
end