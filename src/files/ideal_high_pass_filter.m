function out = ideal_high_pass_filter(img, D0)

img = double(img);
dims = ndims(img);

if dims==2
    [H,W]=size(img);
    F = fftshift(fft2(img));
    Hf = zeros(H,W);

    for u=1:H
        for v=1:W
            D = sqrt((u-H/2)^2 + (v-W/2)^2);
            if D > D0
                Hf(u,v)=1;
            end
        end
    end

    out = real(ifft2(ifftshift(F.*Hf)));

else
    [H,W,C]=size(img);
    out=zeros(H,W,C);

    for k=1:C
        F = fftshift(fft2(img(:,:,k)));
        Hf = zeros(H,W);

        for u=1:H
            for v=1:W
                D = sqrt((u-H/2)^2 + (v-W/2)^2);
                if D > D0
                    Hf(u,v)=1;
                end
            end
        end

        out(:,:,k)=real(ifft2(ifftshift(F.*Hf)));
    end
end

out = uint8(abs(out));

end
