function out = correlation(img)

img = double(img);
dims = ndims(img);

mask = [1 1 1; 1 1 1; 1 1 1];

if dims==2
    [H,W]=size(img);
    p=zeros(H+2,W+2);
    p(2:end-1,2:end-1)=img;
    out=zeros(H,W);

    for i=2:H+1
        for j=2:W+1
            s=0;
            for x=1:3
                for y=1:3
                    s=s+p(i+x-2,j+y-2)*mask(x,y);
                end
            end
            out(i-1,j-1)=s;
        end
    end
else
    [H,W,C]=size(img);
    out=zeros(H,W,C);

    for k=1:C
        p=zeros(H+2,W+2);
        p(2:end-1,2:end-1)=img(:,:,k);
        for i=2:H+1
            for j=2:W+1
                s=0;
                for x=1:3
                    for y=1:3
                        s=s+p(i+x-2,j+y-2)*mask(x,y);
                    end
                end
                out(i-1,j-1,k)=s;
            end
        end
    end
end

out=uint8(out);

end
