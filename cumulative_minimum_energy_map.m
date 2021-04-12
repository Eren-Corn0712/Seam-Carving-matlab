function [cumulativeEnergyMap,from] = cumulative_minimum_energy_map(energyImage, seamDirection)
[rows,cols,~] = size(energyImage);
dp = zeros(rows,cols);
from = zeros(rows,cols);
if strcmp(seamDirection,'VERTICAL')
    for i = 1:cols
        dp(1,i) = energyImage(1,i);
    end
    % find minimum energy
    for j = 2:rows
        for i = 1:cols
            minNeighbor  = dp(j-1,i);
            from(j,i) = i;
            if i > 1 && dp(j-1,i-1) < minNeighbor
                minNeighbor = dp(j-1,i-1);
                from(j,i) = i-1;
            end
            if i < cols && dp(j-1,i+1) < minNeighbor
                minNeighbor = dp(j-1,i+1);
                from(j,i) = i+1;
            end
            dp(j,i) = energyImage(j,i) +minNeighbor;
        end
    end
else
    for i=1:rows
        dp(i,1) = energyImage(i,1);
    end
    for i = 2:cols
        for j = 1:rows
            minNeighbor  = dp(j,i-1);
            from(j,i) = j;
            if j > 1 && dp(j-1,i-1) <  minNeighbor
                minNeighbor = dp(j-1,i-1);
                from(j,i) = j-1;
            end
            if j < rows && dp(j+1,i-1) <  minNeighbor
                minNeighbor = dp(j+1,i-1);
                from(j,i) = j+1;
            end
            dp(j,i) = energyImage(j,i) +minNeighbor;
        end
    end
end
cumulativeEnergyMap = dp;
end
