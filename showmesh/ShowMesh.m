%ShowMesh can both run on windows and linux machine
clear all
 close all

foldername='1000\';

for mmm=40:40
    path_1 = pwd;
    path0=strcat(path_1,'\', 'data', '\', '4_6','\');
    
   [ave_a,ave_b]=GetAandB(path0);
   PlotEllipse(ave_a, ave_b,0,0,0,'k');
   axis equal;
   axis off;
   hold on;
   path1=strcat(path0,foldername,'clu',int2str(mmm),'\');
   FillColors(mmm,path1);

   path2= strcat(path_1,'\', 'images','\', '4_6', '\');
print('-depsc',[path2,'clu','_',num2str(mmm)]);
   hold off
end
   





















