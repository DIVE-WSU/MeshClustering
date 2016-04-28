%Daming Feng
%04/12/2013

function [newCoords,deformedCoords, tris]=ImageBoundaryMesh(inputImage)

fh1 = subplot(1, 1, 1);

[redPixels,width,height]=GetImageBoundary(inputImage);% get the boundary of input image (red)

[a,b,X0_in,Y0_in,phi]=fit_ellipse(redPixels(:,1),redPixels(:,2),1);  %here is the specific ellipse
%load A;

F = fopen('./AandB.txt', 'r');
ave_a = fscanf(F, '%f', 1);
ave_b = fscanf(F, '%f', 1);
fclose(F);

area=48;

[newL,bCoords,Allcoords]=FindBoundaryPoint(ave_a,ave_b,area);% bCoords is column vector
bAngles=GetAngles(bCoords,newL); %aAngle is a raw vector

C=[0 0];
MeshEllipse(Allcoords, C, newL);

[coords]=AdjustCoords(X0_in,Y0_in,bAngles,a,b,phi); % coords are the points on the specific ellipse


[newCoords,tris,nt]=MeshOnAveEllipse();  %show the mesh on average ellipse


minCoord = round(min(coords));
minRed = round(min(redPixels));
coordShift = min(minCoord, minRed) - 1;
extWidth = width - coordShift(1)+10;
extHeight = height - coordShift(2)+10;
bw = zeros(extHeight, extWidth);
for i = 1 : size(redPixels, 1)
    row = round(redPixels(i, 2)) - coordShift(2);
    col = round(redPixels(i, 1)) - coordShift(1);
    bw(row, col) = 1;
end


[D, L] = bwdist(bw);

targetCoords = zeros(size(coords));
for i = 1 : size(coords, 1)
    x = round(coords(i, 1)) - coordShift(1);
    y = round(coords(i, 2)) - coordShift(2);
    [row col] = ind2sub(size(L), L(y, x));
    targetCoords(i, 1) = col + coordShift(1);
    targetCoords(i, 2) = row + coordShift(2);
end


    
deformedCoords = elastic(newCoords, targetCoords, tris);

set(gcf, 'CurrentAxes', fh1); 
for i = 1 : nt
    tri = tris(i, :);
    j0 = 3;
    for j1 = 1 : 3
        XY = deformedCoords([tri(j0), tri(j1)], :);
        line(XY(:, 1), XY(:, 2), 'Color', 'b','LineWidth', 1);
        j0 = j1;
    end
end

end
