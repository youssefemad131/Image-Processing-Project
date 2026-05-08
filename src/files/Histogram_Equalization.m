function newImg = Histogram_Equalization(img)
    img = uint8(img);
    
    if ndims(img) == 3
        isRGB = true;
        hsv = rgb2hsv(img);
        target_channel = uint8(hsv(:,:,3) * 255);
    else
        isRGB = false;
        target_channel = img;
    end

    [H, W] = size(target_channel);
    
    hist = zeros(256, 1);
    for i = 1:H
        for j = 1:W
            val = target_channel(i,j);
            hist(val + 1) = hist(val + 1) + 1;
        end
    end

    pdf = hist / (H * W);
    cdf = zeros(256, 1);
    cdf(1) = pdf(1);
    for i = 2:256
        cdf(i) = cdf(i-1) + pdf(i);
    end

    map = uint8(round(cdf * 255));

    equalized_channel = zeros(H, W, 'uint8');
    for i = 1:H
        for j = 1:W
            equalized_channel(i,j) = map(target_channel(i,j) + 1);
        end
    end

    if isRGB
        hsv(:,:,3) = double(equalized_channel) / 255;
        newImg = uint8(hsv2rgb(hsv) * 255);
    else
        newImg = equalized_channel;
    end
end