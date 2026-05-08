function noisy = SaltPepperAdd(img, Ps, Pp)
img = im2uint8(img);
noisy = img;

    if size(img,3) == 1
        randMat = rand(size(img));
        noisy(randMat < Pp) = 0;
        noisy(randMat > 1 - Ps) = 255;

    else
        for c = 1:3
            randMat = rand(size(img(:,:,c)));
            channel = img(:,:,c);
            channel(randMat < Pp) = 0;
            channel(randMat > 1 - Ps) = 255;
            noisy(:,:,c) = channel;
        end
    end
end