function out = histogram(img)
    if ndims(img) == 3
        img = rgb2gray(img); 
    end
    
    arrhist = zeros(256, 1);
    [w, h] = size(img);
    for i = 1:w
        for j = 1:h
            arrhist(img(i,j) + 1) = arrhist(img(i,j) + 1) + 1;
        end
    end

    f = figure('Visible', 'off');
    bar(0:255, arrhist, 'BarWidth', 1, 'FaceColor', [0.2 0.2 0.2]);
    title('Image Histogram');
    xlabel('Intensity Value');
    ylabel('Frequency');
    grid on;

    frame = getframe(f);
    out = frame.cdata; 
    
    close(f);
end