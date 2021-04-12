function [forward_energy,from] = forward_looking_energy(img,energyImage,seamDirection)
I = double(rgb2gray(img));
[rows,cols] = size(I);
M = zeros(rows,cols);
from = zeros(rows,cols);
if strcmp(seamDirection,'VERTICAL')
    U = circshift(I,1,1);
    L = circshift(I,1,2);
    R = circshift(I,-1,2);
    cv = abs(R-L);
    cl = abs(U-L) + cv;
    cr = abs(U-R) + cv;
    M(1,:) = I(1,:) - I(2,:);
    for j = 2:rows
        for i = 1:cols
            minNeighbor  = M(j-1,i) + cv(j,i);
            from(j,i) = i;
            if i > 1 &&  M(j-1,i-1) + cl(j,i) < minNeighbor
                minNeighbor = M(j-1,i-1) + cl(j,i);
                from(j,i) = i - 1;
            end
            if i < cols && M(j-1,i+1) + cr(j,i) < minNeighbor
                minNeighbor= M(j-1,i+1) + cr(j,i);
                from(j,i) = i + 1;
            end
            M(j,i) = energyImage(j,i) + minNeighbor;
        end
    end
else
    U = circshift(I,1,2);
    L = circshift(I,-1,1);
    R = circshift(I,1,1);
    cv = abs(L-R);
    cl = abs(U-L) + cv;
    cr = abs(U-R) + cv;
    M(:,1) = I(:,1) - I(:,1);
    for i = 2:cols
        for j = 1:rows
            minNeighbor  = M(j,i-1) + cv(j,i);
            from(j,i) = j;
            if j > 1 &&  M(j-1,i-1) + cr(j,i) < minNeighbor
                minNeighbor = M(j-1,i-1) + cr(j,i);
                from(j,i) = j - 1;
            end
            if j < rows && M(j+1,i-1) + cl(j,i) < minNeighbor
                minNeighbor= M(j+1,i-1) + cl(j,i);
                from(j,i) = j + 1;
            end
            M(j,i) = energyImage(j,i) + minNeighbor;
        end
    end
end
forward_energy = M;
end