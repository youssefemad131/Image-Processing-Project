function result = IntensityLevelSlicing(img, low, high)

img = double(img);
result = zeros(size(img));

if ndims(img) == 2   % Grayscale
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            if img(i,j) >= low && img(i,j) <= high
                result(i,j) = 255;
            else
                result(i,j) = 0;
            end
        end
    end

elseif ndims(img) == 3   % RGB
    for c = 1:3
        for i = 1:size(img,1)
            for j = 1:size(img,2)
                if img(i,j,c) >= low && img(i,j,c) <= high
                    result(i,j,c) = 255;
                else
                    result(i,j,c) = 0;
                end
            end
        end
    end
end

result = uint8(result);

end