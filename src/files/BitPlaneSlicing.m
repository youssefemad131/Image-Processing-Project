function out = BitPlaneSlicing(img)
    [R, C, D] = size(img);
    out = zeros(R * 2, C * 4, D, 'uint8');
    
    for d = 1:D
        plane_idx = 0;
        for i = 1:2
            for j = 1:4
                plane = bitand(img(:,:,d), 2^plane_idx);
                
                % Normalize bit to 255 for visibility
                plane_normalized = uint8(logical(plane) * 255);
                
                row_start = (i-1)*R + 1;
                row_end = i*R;
                col_start = (j-1)*C + 1;
                col_end = j*C;
                
                out(row_start:row_end, col_start:col_end, d) = plane_normalized;
                plane_idx = plane_idx + 1;
            end
        end
    end
end