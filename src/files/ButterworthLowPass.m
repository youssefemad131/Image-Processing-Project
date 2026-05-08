function filteredImage = ButterworthLowPass(image, D0, n)

    if nargin < 2, D0 = 30; end 
    if nargin < 3, n = 2; end   

   
    [rows, cols, channels] = size(image);
    imageDouble = double(image);
    
 
    filteredImage = zeros(rows, cols, channels);

 
    u = 0:(rows-1);
    v = 0:(cols-1);
    
   
    idx = find(u > rows/2); u(idx) = u(idx) - rows;
    idy = find(v > cols/2); v(idy) = v(idy) - cols;
    
    [V, U] = meshgrid(v, u);
    
  
    D = sqrt(U.^2 + V.^2);
    
   
    H = 1 ./ (1 + (D ./ D0).^(2 * n));
    
   
    for k = 1:channels
        
      
        F = fft2(imageDouble(:, :, k));
        
    
        G = F .* H;
        
   
        outputChannel = ifft2(G);
        
        filteredImage(:, :, k) = real(outputChannel);
    end

    filteredImage = uint8(filteredImage);
end