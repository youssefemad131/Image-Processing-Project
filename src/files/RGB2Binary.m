function binaryImage = RGB2Binary(rgbImage, threshold)
  
    if nargin < 2
        threshold = 128; 
    end

    
    [rows, cols, channels] = size(rgbImage);
    
   
    if channels == 1
        disp('Warning: Image is already Grayscale.');
    end

 
    binaryImage = zeros(rows, cols);


    for r = 1:rows
        for c = 1:cols
            
        
            if channels == 3
                Red   = double(rgbImage(r, c, 1));
                Green = double(rgbImage(r, c, 2));
                Blue  = double(rgbImage(r, c, 3));
                
               
                grayValue = (0.299 * Red) + (0.587 * Green) + (0.114 * Blue);
            else
                
                grayValue = double(rgbImage(r, c));
            end

          
            if grayValue >= threshold
                binaryImage(r, c) = 1; 
            else
                binaryImage(r, c) = 0; 
            end
            
        end
    end


    binaryImage = logical(binaryImage);
end