function AveEllipse(imageCell)

sum_a=0;
sum_b=0;
for i=1:size(imageCell,1)

    [redPixels,width,height]=GetImageBoundary(imageCell{i,1});
    [a,b,X0_in,Y0_in,phi]=fit_ellipse(redPixels(:,1),redPixels(:,2),1);
    sum_a=sum_a+a;
    sum_b=sum_b+b;
end
ave_a=sum_a/size(imageCell,1);
ave_b=sum_b/size(imageCell,1);

F = fopen('./AandB.txt', 'w');
fprintf(F, '%f\n', ave_a);
fprintf(F, '%f\n', ave_b);
fclose(F);


    