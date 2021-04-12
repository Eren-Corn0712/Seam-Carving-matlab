clc;clear all;close all;
img = imread('Fuji.png');
energyImage = energy_Image(img);
[h,w,~] = size(img);

formatSpec = 'Original Image size is (%d,%d)\n';
fprintf(formatSpec,h,w);

prompt = {'What is image height you want to change',
    'What is image width you want to change',
    'What the compute energy map mathod you want: 0 -> Backward & 1 -> Forward'};
dlgtitle = 'Test Window';
dims =  [1 50; 1 50; 1 75];
definput = {num2str(h),num2str(w),'0'};
answer = inputdlg(prompt,dlgtitle,dims,definput);
height = str2double(answer{1});
width = str2double(answer{2});
if str2double(answer{3}) == 0
    method = 'Backward';
elseif str2double(answer{3}) == 1
    method = 'Forward';
else
    fprintf("Error method");
end

count_height = abs(height - h);
conut_width = abs(width - w);
nums = 100;
if height - h > 0
    while count_height > 0
        [addedColorImage,addedEnergyImage] = addedHeight(img, energyImage,method);
        img = addedColorImage;
        energyImage = addedEnergyImage;
        count_height = count_height -1;
    end
elseif height - h < 0
    while count_height > 0
        [reducedColorImage,reducedEnergyImage] = reduceHeight(img, energyImage,method);
        img = reducedColorImage;
        energyImage = reducedEnergyImage;
        count_height = count_height -1;
    end
else
    [forward_energy,from] = forward_looking_energy(img,energyImage,'VERTICAL');
    display_all_seam(img,from,'VERTICAL',nums);
end

if width - w > 0
    while conut_width > 0
        [addedColorImage,addedEnergyImage] = addedWidth(img, energyImage,method);
        img = addedColorImage;
        energyImage = addedEnergyImage;
        conut_width = conut_width -1;
    end
elseif width - w < 0
    while conut_width > 0
        [reducedColorImage,reducedEnergyImage] = reduceWidth(img, energyImage,method);
        img = reducedColorImage;
        energyImage = reducedEnergyImage;
        conut_width = conut_width -1;
    end
else
    [forward_energy,from] = forward_looking_energy(img,energyImage,'HORIZONTAL');
    display_all_seam(img,from,'HORIZONTAL',nums);
end
figure;imshow(img);
