function out = weighted_filter(img)

img = double(img);
mask = [1 2 1; 
        2 4 2; 
        1 2 1] / 16;

if ndims(img) == 2       % Gray
    out = conv2(img, mask, 'same');

elseif ndims(img) == 3   % RGB
    out = img;
    for c = 1:3
        out(:,:,c) = conv2(img(:,:,c), mask, 'same');
    end
else
    error('Invalid image format');
end

out = uint8(out);
end
