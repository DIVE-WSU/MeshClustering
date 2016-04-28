%Daming Feng
%04/12/2013

function [newCoords,tris,nt]=MeshOnAveEllipse()

F = fopen('./ellipse.1.node', 'r');
np = fscanf(F, '%d', 1);
newCoords = zeros(np, 2);
tmp = fscanf(F, '%d', 1); tmp = fscanf(F, '%d', 1); tmp = fscanf(F, '%d', 1);
for i = 1 : np
    tmp = fscanf(F, '%d', 1);
    newCoords(i, :) = fscanf(F, '%f', 2);
    tmp = fscanf(F, '%d', 1);
end
fclose(F);

F = fopen('./ellipse.1.ele', 'r');
nt = fscanf(F, '%d', 1);
tris = zeros(nt, 3);
tmp = fscanf(F, '%d', 1); tmp = fscanf(F, '%d', 1);
for i = 1 : nt
    tmp = fscanf(F, '%d', 1);
    tris(i, :) = fscanf(F, '%d', 3);
end
fclose(F);

