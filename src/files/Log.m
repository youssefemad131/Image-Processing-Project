function [out] = Log(img)

img = double(img);
dims = ndims(img);
c = 255 / log(1 + max(img(:)));

if dims == 2
    [H, W] = size(img);
    out = zeros(H, W);
    for i = 1:H
        for j = 1:W
            out(i,j) = c * log(1 + img(i,j));
        end
    end
else
    [H, W, C] = size(img);
    out = zeros(H, W, C);
    for i = 1:H
        for j = 1:W
            for k = 1:C
                out(i,j,k) = c * log(1 + img(i,j,k));
            end
        end
    end
end

out = uint8(out);

end
