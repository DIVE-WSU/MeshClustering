%Daming Feng
%04/11/2013

function [redPixels,width,height]=GetImageBoundary(inputImage)

im = imread(inputImage);
%fh1 = subplot(2, 2, 1);
ih = image(im);
axis equal;
axis off;
pixels = get(ih, 'CData'); % ????

width = size(im, 2);
height = size(im, 1);
N = max(height, width);
redPixels = [];
count = 0;
for i = 1 : height
    for j = 1 : width
        rgb = pixels(i, j, :);
        if (rgb(1) > 230) && (rgb(2) < 100) && (rgb(3) < 100) 
            count = count + 1;
            redPixels(count, 2) = i;
            redPixels(count, 1) = j;
        end
    end
end
