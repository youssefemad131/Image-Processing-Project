function new = neg(r)

    r = double(r);

    if ndims(r) == 3
        % -------- RGB Image --------
        [H, W, C] = size(r);
        new = zeros(H, W, C);

        for i = 1:H
            for j = 1:W
                for k = 1:C
                    new(i,j,k) = 255 - r(i,j,k);
                end
            end
        end

    else
        % -------- Grayscale or Binary --------
        [H, W] = size(r);
        new = zeros(H, W);

        for i = 1:H
            for j = 1:W
                new(i,j) = 255 - r(i,j);
            end
        end
    end

    % Clamp values
    new(new > 255) = 255;
    new(new < 0)   = 0;

    new = uint8(new);

end
