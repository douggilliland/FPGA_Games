im = imread('start.bmp');
[a,b,c] = size(im);
a, b, c
rgbs = im;
imshow(rgbs);
fid = fopen( 'start.coe', 'w+' );
fprintf( fid, 'memory_initialization_radix=2;\n');
fprintf( fid, 'memory_initialization_vector =\n');
for i = 1 : a
    for j = 1 : b
        fprintf( fid, '%d',rgbs(i, j, 1) > 0);
        fprintf( fid, '%d',rgbs(i, j, 2) > 0);
        fprintf( fid, '%d,\n',rgbs(i, j, 3) > 0);
    end
end
fprintf( fid, ';');
fclose( fid );