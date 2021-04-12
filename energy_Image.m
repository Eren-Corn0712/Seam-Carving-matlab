function energyImage = energy_Image(img)
assert(isa(img,'uint8'), 'Image must be unit8');
[~, ~, d] = size(img);
gray = double(rgb2gray(img))/255.0;
if d == 3
    [Gx,Gy] = imgradientxy(gray,'sobel');
else
    fprint('Must RGB Image');
end
energyImage = abs(Gx) + abs(Gy);
% figure;imagesc(energyImage);colorbar;
end