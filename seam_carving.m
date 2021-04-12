function srcImg = seam_carving(n,srcImg)
rng('default')
figure;imshow(srcImg);
[ h, w ] = size( srcImg );
if n == 1
    %         mask_destroy = roipoly;
    mask_protect = roipoly;
    [h,w,c] = size(srcImg);
    flag = 255;
    figure;
    while flag ~= 0
        copy = srcImg;
        gray_img = rgb2gray(srcImg);
        [gMag gDir] = imgradient(gray_img);
        %             gMag(mask_destroy==1) = (-1)*10^18;
        gMag(mask_protect==1) = 10^18;
        dp = zeros(h,w);
        from = zeros(h,w);
        
        % copy location
        for i = 1:w
            dp(1,i) = gMag(1,i);
        end
        
        
        % find minimum energy
        for j = 2:h
            for i = 1:w
                minNeighbor  = dp(j-1,i);
                from(j,i) = i;
                if i > 1 && dp(j-1,i-1) < minNeighbor
                    minNeighbor = dp(j-1,i-1);
                    from(j,i) = i-1;
                end
                if i < w && dp(j-1,i+1) < minNeighbor
                    minNeighbor = dp(j-1,i+1);
                    from(j,i) = i+1;
                end
                dp(j,i) = gMag(j,i) +minNeighbor;
            end
        end
        
        % find minimum index
        mn = 10^18;
        idx = -1;
        for i = 1:w
            if dp(h,i) < mn
                mn = dp(h,i);
                idx = i;
            end
        end
        % track path
        path = 0;
        for j = h:-1:1
            if path == 0
                path = [idx];
            else
                path = [idx path];
            end
            idx =from(j,idx);
        end
        
        for j = h:-1:1
            copy(j,path(j),1) = 255;
            copy(j,path(j),2) = 0;
            copy(j,path(j),3) = 0;
        end
        
        
        for j = h:-1:1
            for i = path(j):w-1
                srcImg(j,i,:) = srcImg(j,i+1,:);
                %                     mask_destroy(j,i,:) = mask_destroy(j,i+1,:);
                mask_protect(j,i,:) = mask_protect(j,i+1,:);
            end
        end
        
        srcImg(:,w,:) = [];
        %             mask_destroy(:,w,:) = [];
        mask_protect(:,w,:)=[];
        
        
        %             imshow(mask_destroy);drawnow;
        %             imshow(copy);drawnow;
        [h,w,~] = size(srcImg);
        flag = flag-1;
    end
    
    
    
elseif n == 2
    count = 100;
    figure;
    while count ~= 0
        copy = srcImg;
        [h, w, c] = size( srcImg );
        gray_img = rgb2gray(srcImg);
        [gMag gDir] = imgradient(gray_img);
        dp = zeros(h,w);
        from = zeros(h,w);
        % copy location
        for i = 1:w
            dp(1,i) = gMag(1,i);
        end
        % find minimum energy
        for j = 2:h
            for i = 1:w
                minNeighbor  = dp(j-1,i);
                from(j,i) = i;
                if i > 1 && dp(j-1,i-1) < minNeighbor
                    minNeighbor = dp(j-1,i-1);
                    from(j,i) = i-1;
                end
                if i < w && dp(j-1,i+1) < minNeighbor
                    minNeighbor = dp(j-1,i+1);
                    from(j,i) = i+1;
                end
                dp(j,i) = gMag(j,i) +minNeighbor;
            end
        end
        idx = round(randi(randi(w)))
        % track path
        path = 0;
        for j = h:-1:1
            if path == 0
                path = [idx];
            else
                path = [idx path];
            end
            idx =from(j,idx);
        end
        for j = h:-1:1
            copy(j,path(j),1) = 255;
            copy(j,path(j),2) = 0;
            copy(j,path(j),3) = 0;
            
        end
        imshow(copy);drawnow;
        addcols = srcImg(:,1,:);
        srcImg = [addcols,srcImg];
        for j = 1 : h
            for i = 1 : path( 1, j)
                srcImg( j, i, :) = srcImg( j, i+1, :);
            end
            if path( 1, j ) + 2 > w
                srcImg( j, path( 1, j) , :) = srcImg(j, path(1, j) + 1, : );
            else
                srcImg( j, path(1, j) + 1, :) = srcImg(j, path(1, j), :) / 2 + srcImg(j, path(1, j) + 1, :) / 2;
            end
        end
        count = count -1;
    end
end
end
