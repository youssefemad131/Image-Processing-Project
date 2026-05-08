function out = SaltPepperRemove(img, win)
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

    for c = 1:C
        for i = 1:H
            for j = 1:W
                vec = zeros(win*win, 1);
                k = 1;
                for u = -r:r
                    for v = -r:r
                        ii = i + u;  jj = j + v;

                        if ii < 1, ii = 1; end
                        if ii > H, ii = H; end
                        if jj < 1, jj = 1; end
                        if jj > W, jj = W; end

                        vec(k) = img(ii, jj, c);
                        k = k + 1;
                    end
                end

                n = length(vec);
                for a = 2:n
                    key = vec(a);
                    b = a - 1;
                    while b >= 1 && vec(b) > key
                        vec(b+1) = vec(b);
                        b = b - 1;
                    end
                    vec(b+1) = key;
                end

                out(i,j,c) = vec(floor(n/2) + 1);
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
