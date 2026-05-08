function out = closing(img, se, padValue)
    temp = dilation(img, se, padValue);
    out  = erosion(temp, se, padValue);
end
