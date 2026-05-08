function out = padding(img, padH, padW, padValue)

    originalType = class(img);
    img = double(img);

    if ndims(img) == 2
        [H, W] = size(img);
        C = 1;
    else
        [H, W, C] = size(img);
    end

    newH = H + 2*padH;
    newW = W + 2*padW;

    out = zeros(newH, newW, C);
    for c = 1:C
        for i = 1:newH
            for j = 1:newW
                out(i,j,c) = padValue;
            end
        end
    end

    for c = 1:C
        for i = 1:H
            for j = 1:W
                out(i + padH, j + padW, c) = img(i,j,c);
            end
        end
    end

    out = cast(out, originalType);
end
