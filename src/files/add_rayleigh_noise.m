function noisy_img = add_rayleigh_noise(img, a, b)
    img = double(img);
    [h, w, l] = size(img);
    noisy_img = img;

    % Loop through each channel and pixel
    for k = 1:l
        for r = 1:h
            for c = 1:w
                R = a + b * sqrt(-2 * log(1 - rand())); 
                noisy_img(r, c, k) = noisy_img(r, c, k) + R;
            end
        end
    end

    % Normalize to [0, 255] after adding noise
    for k = 1:l
        mn = min(min(noisy_img(:,:,k)));
        mx = max(max(noisy_img(:,:,k)));
        noisy_img(:,:,k) = ((noisy_img(:,:,k)-mn)/(mx-mn))*255;
    end

    noisy_img = uint8(noisy_img);
end
