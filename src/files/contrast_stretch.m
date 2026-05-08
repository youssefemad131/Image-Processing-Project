function result = contrast_stretch(i)
i = double(i);
i_min = min(i(:));
i_max = max(i(:));

result = (i - i_min) * (255 / (i_max - i_min));
result = uint8(result);

end

