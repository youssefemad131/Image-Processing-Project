function out = dilation(img, se, padValue)
    originalType = class(img);
    if ndims(img) == 2
        [H, W] = size(img);
        C = 1;
    else
        [H, W, C] = size(img);
    end

    [sh, sw] = size(se);
    r = floor(sh/2);
    s = floor(sw/2);

    padded = padding(img, r, s, padValue);
    padded = double(padded);

    out = zeros(H, W, C);

    for c = 1:C
        for i = 1:H
            for j = 1:W

                found = false;
                best = 0;

                for u = 1:sh
                    for v = 1:sw
                        if se(u,v) ~= 0
                            val = padded(i+u-1, j+v-1, c);
                            if ~found
                                best = val;
                                found = true;
                            elseif val > best
                                best = val;
                            end
                        end
                    end
                end

                if ~found
                    error('Structuring element se has no nonzero values.');
                end

                out(i,j,c) = best;
            end
        end
    end

    out = cast(out, originalType);
end
