function noisy = AddGammaNoise(img, a, b)
    [M, N, D] = size(img);
    img = double(img);
    noisy = zeros(M, N, D);
    
    for d = 1:D
        gamma_noise = zeros(M, N);
        for i = 1:a
            u = rand(M, N);
            gamma_noise = gamma_noise - (1/b) * log(1 - u);
        end
        noisy(:,:,d) = img(:,:,d) + gamma_noise;
    end
    
    noisy = uint8(noisy);
end