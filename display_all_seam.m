function display_img = display_all_seam(img,from,type,nums)
[rows, cols, ~] = size(img);
display_img = img;
if strcmp(type, 'VERTICAL')
    for k = 1:nums
        index =round(randi(cols));
        for j = rows:-1:1
            display_img(j,index,1) = 255;
            display_img(j,index,2) = 0;
            display_img(j,index,3) = 0;
            index = from(j,index);
        end
    end
else
    for k = 1:nums
        index =round(randi(rows));
        for i = cols:-1:1
            display_img(index,i,1) = 255;
            display_img(index,i,2) = 0;
            display_img(index,i,3) = 0;
            index = from(index,i);
        end
    end
end
figure;imshow(display_img);
end