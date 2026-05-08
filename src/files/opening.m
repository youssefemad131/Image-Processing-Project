function out = opening(img, se, padValue)

    temp = erosion(img, se, padValue);
    out  = dilation(temp, se, padValue);
end
