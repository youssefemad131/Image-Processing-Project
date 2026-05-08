function out = ImageNegative(img)
    if size(img, 3) == 1
        out = 255 - img;
    else
        out = 255 - img;
    end
end