function result = gaussianHPF(img, D0)

img = double(img);
[H, W, C] = size(img);
result = zeros(H, W, C);

% -------- Gaussian Kernel Parameters --------
kernel_size = 5;           % ???? ????
half = floor(kernel_size/2);
sigma = D0;

% -------- Build Gaussian Kernel Manually --------
kernel = zeros(kernel_size, kernel_size);
sum_val = 0;

for x = -half:half
    for y = -half:half
        value = exp(-(x^2 + y^2) / (2 * sigma^2));
        kernel(x+half+1, y+half+1) = value;
        sum_val = sum_val + value;
    end
end

% Normalize kernel
for i = 1:kernel_size
    for j = 1:kernel_size
        kernel(i,j) = kernel(i,j) / sum_val;
    end
end

% -------- Apply Gaussian LPF then HPF --------
for c = 1:C
    for i = 1:H
        for j = 1:W
            
            blur = 0;
            
            for x = -half:half
                for y = -half:half
                    ni = i + x;
                    nj = j + y;
                    
                    if ni >= 1 && ni <= H && nj >= 1 && nj <= W
                        blur = blur + img(ni,nj,c) * ...
                               kernel(x+half+1, y+half+1);
                    end
                end
            end
            
            % High Pass = Original - Low Pass
            result(i,j,c) = img(i,j,c) - blur;
        end
    end
end

% -------- Clip Values --------
for c = 1:C
    for i = 1:H
        for j = 1:W
            if result(i,j,c) < 0
                result(i,j,c) = 0;
            elseif result(i,j,c) > 255
                result(i,j,c) = 255;
            end
        end
    end
end

result = uint8(result);

end