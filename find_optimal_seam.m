function seam = find_optimal_seam(cumulativeEnergyMap,from,type)

[rows, columns, ~] = size(cumulativeEnergyMap);
mn = 10^18;
path = 0;
index = -1;
if strcmp(type,'VERTICAL')
    for i = 1:columns
        if cumulativeEnergyMap(rows,i) < mn
            mn = cumulativeEnergyMap(rows,i);
            index = i;
        end
    end
%         index = round(randi(columns));
    for j = rows:-1:1
        if path == 0
            path = [index];
        else
            path = [index,path];
        end
        index = from(j,index);
    end
else
    for j = 1:rows
        if cumulativeEnergyMap(j,columns) < mn
            mn = cumulativeEnergyMap(j,columns);
            index = j;
        end
    end
%     index = round(randi(rows));
    for i = columns:-1:1
        if path == 0
            path = [index];
        else
            path = [index,path];
        end
        index = from(index,i);
    end
end
seam = path;
end