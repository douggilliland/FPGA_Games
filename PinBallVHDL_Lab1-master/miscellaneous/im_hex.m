function [IMAGE,MASK] = im_hex( image, width, height, filter )
    if(nargin < 4) filter = 'FF'; end                                       % default BG filter is white         
    
    x = imread(image);
    x = imresize(x, [height, width]);                                       % resize image if needed
    r = x(:, :, 1); r = floor(double(r)/32);                                % convert to 3-bit RRR
    g = x(:, :, 2); g = floor(double(g)/32);                                % convert to 3-bit GGG
    b = x(:, :, 3); b = floor(double(b)/64);                                % convert to 2-bit BB

    out = ''; msk = '';
    for row = 1:height
        out = [out, '('];
        msk = [msk, '("'];
        for col = 1:width
            color = bin2dec([dec2bin(r(row, col), 3), dec2bin(g(row, col), 3), dec2bin(b(row, col), 2)]);
            if(color == hex2dec(filter))
                msk = [msk, '0'];
            else
                msk = [msk, '1'];
            end
            out = [out, sprintf('x"%.2x"', color)]; 
            if(col < width)
                out = [out, ','];
            end
        end
        out = [out, ')'];
        msk = [msk, '")'];
        if(row < height)
            out = [out, sprintf(',\n')];
            msk = [msk, sprintf(',\n')];
        end     
    end
    IMAGE = out;
    MASK = msk;
    
    %file_name = strcat(image,'_post_im_hex.txt');
    %headerStr = sprintf('%s\n Object Dimentions:\n X: %d\nY:  %d\n\n',image,width,hight);
    
    %fileID = fopen(file_name,'wt');
    %fprintf(fileID,headerStr);
    %fprintf(fileID,'constant object_colors: ram_array := (\n%s\n);\n\n',out);
    %fprintf(fileID,'constant object : object_form := (\n%s\n);\n\n',msk);
    %fclose(fileID);
    
end