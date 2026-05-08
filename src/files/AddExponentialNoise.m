function noisy = AddExponentialNoise(img, a, b)
    [M, N, D] = size(img);
    img = double(img);
    noisy = zeros(M, N, D);
    
    for d = 1:D
        u = rand(M, N);
        
        noise = -(1/a) * log(1 - u) * b;
        
        noisy(:,:,d) = img(:,:,d) + noise;
    end
    
    noisy = uint8(noisy);
end