function out = geometric_mean_filter(img, win)
    originalType = class(img);
    img = double(img);
    if ndims(img) == 2
        [H, W] = size(img);
        C = 1;
    else
        [H, W, C] = size(img);
    end

    r = floor(win/2);
    out = zeros(H, W, C);
    epsv = 1;
    for c = 1:C
        for i = 1:H
            for j = 1:W
                sumLog = 0;
                count  = 0;
                for u = -r:r
                    for v = -r:r
                        ii = i + u;
                        jj = j + v;

                        if ii < 1, ii = 1; end
                        if ii > H, ii = H; end
                        if jj < 1, jj = 1; end
                        if jj > W, jj = W; end

                        val = img(ii, jj, c);

                        sumLog = sumLog + log(val + epsv);
                        count  = count + 1;
                    end
                end

                out(i, j, c) = exp(sumLog / count) - epsv;
            end
        end
    end
    for c = 1:C
        for i = 1:H
            for j = 1:W
                if out(i,j,c) < 0
                    out(i,j,c) = 0;
                elseif out(i,j,c) > 255
                    out(i,j,c) = 255;
                end
            end
        end
    end

    out = cast(out, originalType);
end
