function MeshEllipse(coords, C, L)

% meshing ellipse interior using Triangle
% Daming Feng
% 04/11/2013

area=sqrt(3)/4*L^2;

np = size(coords, 1);
F = fopen('./ellipse.poly', 'w');
fprintf(F, '%d 2 0 0\n', np + 1);
for i = 1 : np
    fprintf(F, '%d %f %f\n', i, coords(i, 1), coords(i, 2));
end
fprintf(F, '%d %f %f\n', np + 1, C(1), C(2));
fprintf(F, '%d 0\n', np);
for i = 1 : np - 1
    fprintf(F, '%d %d %d\n', i, i, i + 1);
end
fprintf(F, '%d %d %d\n', np, np, 1);
fprintf(F, '0\n');
fclose(F);

root = pwd;
path=strcat(root, '/triangle -pq25a', num2str(area),'Q ./ellipse.poly');

system(path);

end

