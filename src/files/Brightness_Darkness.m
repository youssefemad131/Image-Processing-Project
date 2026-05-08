function [B_D] = Brightness_Darkness(img, offset, option)
    img = double(img);
    [H, W, C] = size(img);
    B_D = zeros(H, W, C);

    for k = 1:C
        for a = 1:H
            for b = 1:W
                if option == 1
                    B_D(a,b,k) = img(a,b,k) + offset;
                elseif option == 2
                    B_D(a,b,k) = img(a,b,k) * offset;
                elseif option == 3
                    B_D(a,b,k) = img(a,b,k) - offset;
                elseif option == 4
                    B_D(a,b,k) = img(a,b,k) / offset;
                end
            end
        end
    end

    B_D(B_D > 255) = 255;
    B_D(B_D < 0)   = 0;
    B_D = uint8(B_D);
end