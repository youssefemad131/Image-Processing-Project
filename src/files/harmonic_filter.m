function out = harmonic_filter(img, k)

img = double(img);
dims = ndims(img);
r = floor(k/2);

if dims==2
    [H,W]=size(img);
    p=zeros(H+2*r,W+2*r);
    p(r+1:end-r,r+1:end-r)=img;
    out=zeros(H,W);

    for i=1:H
        for j=1:W
            s=0;
            for x=1:k
                for y=1:k
                    if p(i+x-1,j+y-1)~=0
                        s=s+1/p(i+x-1,j+y-1);
                    end
                end
            end
            out(i,j)=k*k/s;
        end
    end
else
    [H,W,C]=size(img);
    out=zeros(H,W,C);
    for c=1:C
        p=zeros(H+2*r,W+2*r);
        p(r+1:end-r,r+1:end-r)=img(:,:,c);
        for i=1:H
            for j=1:W
                s=0;
                for x=1:k
                    for y=1:k
                        if p(i+x-1,j+y-1)~=0
                            s=s+1/p(i+x-1,j+y-1);
                        end
                    end
                end
                out(i,j,c)=k*k/s;
            end
        end
    end
end

out(out<0)=0;
out(out>255)=255;
out=uint8(out);

end
