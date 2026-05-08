function result = DFT(img)
    img = double(img); 
    [M, N, D] = size(img);
    F = zeros(M, N, D);
    
    for d = 1:D
        F(:,:,d) = fftshift(fft2(img(:,:,d)));
    end
    
    result = log(1 + abs(F));
    
    result = mat2gray(result);
end