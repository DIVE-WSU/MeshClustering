%Daming Feng
%04/19/2013

function [ave_a,ave_b]=GetAandB(path0)

file=strcat(path0,'AandB.txt');
F = fopen(file, 'r');
ave_a = fscanf(F, '%lf', 1);
ave_b = fscanf(F, '%lf', 1);
fclose(F);