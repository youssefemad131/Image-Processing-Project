function outputImg = GaussianOperations(image, mode, sigma, meanVal)
  
    if nargin < 3, sigma = 10; end  
    if nargin < 4, meanVal = 0; end 

    [rows, cols, channels] = size(image);
    imgDouble = double(image);
    outputImg = zeros(rows, cols, channels);


    if strcmp(mode, 'add')
        
      
        noise = randn(rows, cols, channels);
        
      
        gaussianNoise = (noise * sigma) + meanVal;
        
     
        noisyImage = imgDouble + gaussianNoise;
        

        noisyImage(noisyImage > 255) = 255;
        noisyImage(noisyImage < 0) = 0;
        
        outputImg = uint8(noisyImage);

   
    elseif strcmp(mode, 'remove')

        kernelSize = 2 * ceil(3 * sigma) + 1;
        halfSize = floor(kernelSize / 2);
        
        kernel = zeros(kernelSize, kernelSize);
        
        for x = -halfSize : halfSize
            for y = -halfSize : halfSize
                
                numerator = -(x^2 + y^2);
                denominator = 2 * (sigma^2);
                value = exp(numerator / denominator);
                
                kernel(x + halfSize + 1, y + halfSize + 1) = value;
            end
        end
        
        kernel = kernel / sum(kernel(:));
        
        
        pad = halfSize;
        paddedImg = zeros(rows + 2*pad, cols + 2*pad, channels);
        paddedImg(pad+1 : end-pad, pad+1 : end-pad, :) = imgDouble;
        
        for k = 1:channels
            for r = 1:rows
                for c = 1:cols
                    r_pad = r + pad;
                    c_pad = c + pad;
                    
                    window = paddedImg(r_pad-pad : r_pad+pad, c_pad-pad : c_pad+pad, k);
                    
                    
                    weightedSum = sum(sum(window .* kernel));
                    
                    outputImg(r, c, k) = weightedSum;
                end
            end
        end
        
        outputImg = uint8(outputImg);
        
    else
        error('Invalid mode! Use "add" or "remove".');
    end
end