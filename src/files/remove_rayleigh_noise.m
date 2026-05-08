function clean_img = remove_rayleigh_noise(img)
    img = double(img);
    [h, w, l] = size(img);
    clean_img = img;

    for k = 1:l
        mn = min(min(clean_img(:,:,k)));
        mx = max(max(clean_img(:,:,k)));
        clean_img(:,:,k) = ((clean_img(:,:,k)-mn)/(mx-mn))*255;
    end

    clean_img = uint8(clean_img);
end
