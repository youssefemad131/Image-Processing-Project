function out = PointDetection(img)
    img = double(img);
    mask = [-1 -1 -1; -1 8 -1; -1 -1 -1];
    
    [H, W, D] = size(img);
    
    out = zeros(H, W, D);
    
    for d = 1:D
        for i = 2:H-1
            for j = 2:W-1
                region = img(i-1:i+1, j-1:j+1, d);
                
                out(i,j,d) = sum(sum(region .* mask));
            end
        end
    end
    
    out = uint8(abs(out));
end