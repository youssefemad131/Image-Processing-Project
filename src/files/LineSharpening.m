function out = LineSharpening(img)

img = double(img);
dims = ndims(img);

masks(:,:,1) = [-1 -1 -1;  2  2  2; -1 -1 -1];
masks(:,:,2) = [-1  2 -1; -1  2 -1; -1  2 -1];
masks(:,:,3) = [ 2 -1 -1; -1  2 -1; -1 -1  2];
masks(:,:,4) = [-1 -1  2; -1  2 -1;  2 -1 -1];

if dims==2
    [H,W]=size(img);
    p=zeros(H+2,W+2);
    p(2:end-1,2:end-1)=img;
    out=zeros(H,W);

    for i=2:H+1
        for j=2:W+1
            s=0;
            for k=1:4
                for x=1:3
                    for y=1:3
                        s=s+p(i+x-2,j+y-2)*masks(x,y,k);
                    end
                end
            end
            out(i-1,j-1)=abs(s);
        end
    end

else
    [H,W,C]=size(img);
    out=zeros(H,W,C);

    for c=1:C
        p=zeros(H+2,W+2);
        p(2:end-1,2:end-1)=img(:,:,c);
        for i=2:H+1
            for j=2:W+1
                s=0;
                for k=1:4
                    for x=1:3
                        for y=1:3
                            s=s+p(i+x-2,j+y-2)*masks(x,y,k);
                        end
                    end
                end
                out(i-1,j-1,c)=abs(s);
            end
        end
    end
end

out = uint8(out);

end
