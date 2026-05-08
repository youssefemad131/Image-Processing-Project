function out = uniform_noise(img, a, b, perc, mode)
    img = double(img);
    dims = ndims(img);

    if dims == 2
        [H, W] = size(img);
        out = img;
        for i = 1:H
            for j = 1:W
                if rand <= perc
                    n = a + (b-a)*rand;
                    if mode == 'a'
                        out(i,j) = img(i,j) + n;
                    else
                        out(i,j) = img(i,j) - n;
                    end
                end
            end
        end
    else
        [H, W, C] = size(img);
        out = img;
        for k = 1:C
            for i = 1:H
                for j = 1:W
                    if rand <= perc
                        n = a + (b-a)*rand;
                        if mode == 'a'
                            out(i,j,k) = img(i,j,k) + n;
                        else
                            out(i,j,k) = img(i,j,k) - n;
                        end
                    end
                end
            end
        end
    end

    out(out < 0) = 0;
    out(out > 255) = 255;
    out = uint8(out);
end