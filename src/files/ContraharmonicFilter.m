function filteredImage = ContraharmonicFilter(image, maskSize, Q)
    if nargin < 2, maskSize = 3; end
    if nargin < 3, Q = 1.5; end 

    [rows, cols, channels] = size(image);
    
    imgDouble = double(image);
    
    pad = floor(maskSize / 2);
    paddedImg = zeros(rows + 2*pad, cols + 2*pad, channels);
    paddedImg(pad+1 : end-pad, pad+1 : end-pad, :) = imgDouble;
    
    filteredImage = zeros(rows, cols, channels);
    
    for k = 1:channels
        for r = 1:rows
            for c = 1:cols
                
                r_pad = r + pad;
                c_pad = c + pad;
                
                window = paddedImg(r_pad-pad : r_pad+pad, c_pad-pad : c_pad+pad, k);
                
                window = window + eps; 
                
        
                numerator = sum(sum(window .^ (Q + 1)));
                
              
                denominator = sum(sum(window .^ Q));
                
           
                result = numerator / denominator;
                
            
                filteredImage(r, c, k) = result;
                
            end
        end
    end

    filteredImage = uint8(filteredImage);
end