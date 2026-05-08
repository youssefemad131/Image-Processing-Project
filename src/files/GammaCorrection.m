function correctedImage = GammaCorrection(image, gammaVal)
  
    if nargin < 2
        gammaVal = 1.0; 
    end

  
    [rows, cols, channels] = size(image);
    
  
    correctedImage = zeros(rows, cols, channels);
    
   
    for k = 1:channels       
        for r = 1:rows        
            for c = 1:cols   
                
              
                pixel = double(image(r, c, k));
                
                normalizedPixel = pixel / 255.0;
                
               
                newPixelVal = normalizedPixel ^ gammaVal;
                
               
                correctedImage(r, c, k) = newPixelVal * 255.0;
                
            end
        end
    end


    correctedImage = uint8(correctedImage);
end