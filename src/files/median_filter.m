function [new_rgb] = median_filter(RGB)

RGB = double(RGB); 
[H, W, L] = size(RGB);
new_rgb = zeros(H, W, L);

mask_size = 3;
padd_size = 1;

padded_img = padarray(RGB, [padd_size, padd_size], 'replicate'); 

for ch = 1:L
    for i = 1:H
        for j = 1:W
            
            r1 = i;
            r2 = i + mask_size - 1;
            c1 = j;
            c2 = j + mask_size - 1;
            
            mask = padded_img(r1:r2, c1:c2, ch); 
            
            mask_vals = mask(:);
            new_val = median(mask_vals);
            
            new_rgb(i, j, ch) = new_val;
            
        end
    end
end

new_rgb = uint8(new_rgb);

end