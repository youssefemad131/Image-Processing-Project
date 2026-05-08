function result = gaussianLPF(img, D0)
    img = im2double(img);
    result = zeros(size(img));

    if size(img,3) == 1
        channels = 1;
    else
        channels = 3;
    end

    for c = 1:channels
        if channels == 1
            I = img;
        else
            I = img(:,:,c);
        end

        [M, N] = size(I);
        u = 0:N-1;
        v = 0:M-1;
        u = u - floor(N/2);
        v = v - floor(M/2);
        [U, V] = meshgrid(u, v);

        D = sqrt(U.^2 + V.^2);

        H = exp(-(D.^2) / (2 * (D0^2)));

        F = fft2(I);
        F = fftshift(F);
        G = H .* F;
        G = ifftshift(G);
        G = ifft2(G);
        G = real(G);

        if channels == 1
            result = G;
        else
            result(:,:,c) = G;
        end
    end

    result = im2uint8(result);
end