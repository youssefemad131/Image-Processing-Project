function out = line_detection(img, method, direction)
img = double(img);
[H, W, C] = size(img);
out = zeros(H, W, C);

for c = 1:C
    switch lower(method)
        case 'roberts'
            switch upper(direction)
                case 'H'
                    mask = [1 -1; 1 -1];
                case 'V'
                    mask = [1 1; -1 -1];
                case 'DL'
                    mask = [0 1; -1 0];
                case 'DR'
                    mask = [1 0; 0 -1];
            end
        case 'sobel'
            switch upper(direction)
                case 'H'
                    mask = [-1 0 1; -2 0 2; -1 0 1];
                case 'V'
                    mask = [-1 -2 -1; 0 0 0; 1 2 1];
            end
    end
    
    [mH, mW] = size(mask);
    halfH = floor(mH/2);
    halfW = floor(mW/2);
    
    for i = 1:H
        for j = 1:W
            sum_val = 0;
            for x = 1:mH
                for y = 1:mW
                    ni = i + x - halfH - 1;
                    nj = j + y - halfW - 1;
                    if ni >= 1 && ni <= H && nj >= 1 && nj <= W
                        sum_val = sum_val + img(ni,nj,c) * mask(x,y);
                    end
                end
            end
            out(i,j,c) = sum_val;
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

out = uint8(out);
end