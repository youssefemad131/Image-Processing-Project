function output = adaptive_filter(img, window_size, noise_var)

img = double(img);
output = zeros(size(img));

pad = floor(window_size / 2);
padded = padarray(img, [pad pad], 'replicate');

if size(img,3) == 1
    channels = 1;
else
    channels = 3;
end

for c = 1:channels
    
    if channels == 1
        I = padded;
    else
        I = padded(:,:,c);
    end
    
    for i = 1+pad : size(I,1)-pad
        for j = 1+pad : size(I,2)-pad
            
            window = I(i-pad:i+pad, j-pad:j+pad);
            
            local_mean = mean(window(:));
            local_var  = var(window(:));
            
            pixel = I(i,j);
            
            if local_var == 0
                new_val = local_mean;
            else
                new_val = pixel - (noise_var / local_var) * (pixel - local_mean);
            end
            
            if channels == 1
                output(i-pad,j-pad) = new_val;
            else
                output(i-pad,j-pad,c) = new_val;
            end
            
        end
    end
end

output = uint8(max(min(output,255),0));
end
