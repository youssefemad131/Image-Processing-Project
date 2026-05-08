function output = IdealLowPassFilter(img, D0)

if size(img,3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

[M,N] = size(img_gray);
[u,v] = meshgrid(-floor(N/2):ceil(N/2)-1, -floor(M/2):ceil(M/2)-1);
D = sqrt(u.^2 + v.^2);
H = double(D <= D0);

F = fft2(double(img_gray));
F = fftshift(F);

G = H .* F;
G = ifftshift(G);
output = real(ifft2(G));
output = uint8(mat2gray(output)*255);

end