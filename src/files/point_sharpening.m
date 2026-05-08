function out = point_sharpening(img)

img = double(img);

mask = [ 0 -1  0;
        -1  4 -1;
         0 -1  0 ];

if ndims(img) == 2
    [H, W] = size(img);
    C = 1;
else
    [H, W, C] = size(img);
end

lap = zeros(H, W, C);

for c = 1:C
    for i = 1:H
        for j = 1:W
            s = 0;
            for u = -1:1
                for v = -1:1
                    ii = i + u;
                    jj = j + v;

                    if ii >= 1 && ii <= H && jj >= 1 && jj <= W
                        s = s + img(ii, jj, c) * mask(u+2, v+2);
                    end
                end
            end
            lap(i, j, c) = s;
        end
    end
end

out = img + lap;

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
