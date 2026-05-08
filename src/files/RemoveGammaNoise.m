function out = RemoveGammaNoise(img)
    img = double(img);
    [H, W, D] = size(img);
    out = zeros(H, W, D);
    
    mask = ones(3, 3) / 9;
    
    for d = 1:D
        for i = 2:H-1
            for j = 2:W-1
                region = img(i-1:i+1, j-1:j+1, d);
                out(i,j,d) = sum(sum(region .* mask));
            end
        end
    end
    out = uint8(out);
end