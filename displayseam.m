function display_img=displayseam(img,seam,type)
[rows, columns, ~] = size(img);
display_img = img;
if strcmp(type, 'VERTICAL')
    for i = 1:rows
        display_img(i,seam(i),1) = 255;
        display_img(i,seam(i),2) = 0;
        display_img(i,seam(i),3) = 0;
    end
else
    for i = 1:columns
        display_img(seam(i), i,1) = 255;
        display_img(seam(i), i,2) = 0;
        display_img(seam(i), i,3) = 0;
    end
end

figure;imshow(display_img);
end