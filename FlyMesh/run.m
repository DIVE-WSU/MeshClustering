clear all
close all
clc

dir_root1 = pwd;
dir_root = strcat(pwd, '/', 'test_images');
b = dir(dir_root);

for j = 3: (size(b,1)-1)
    name_1{1,j-2} = b(j,1).name;
end
dir_root_dmatrix = strcat(pwd, '/', 'test_images_result');
mkdir(dir_root_dmatrix);

for j = 1 : size(name_1,2)
 
    j
    dir_2 = name_1(1,j);
    temp = dir_2{1,1};
    if (isempty(temp) == 0)
		files = temp;
        name_2 = strtok(temp,'.');
        aa = [dir_root, '/',temp]; 
        [newCoords,coords, tris] = ImageBoundaryMesh(aa);
        path_to_save = char (strcat(dir_root_dmatrix,'/', name_2, '.mat'));
           %imwrite(J,path_to_save);
        save(path_to_save, 'newCoords','coords','tris');
        clear path_to_save newCoords coords tris 
    end
end  

