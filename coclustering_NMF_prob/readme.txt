%%%[IDX,IDY,ierr,ferr]=exe_co_evol_nmf(A,'cluster',cluster,'mu',alpha,'repli',100,'iter',40,'torr',0.001);
by Wenlu Zhang 
[IDX,IDY,~,~,~,proX,proY]=exe_co_evol_nmf(A,'cluster',cluster,'mu',alpha,'repli',20,'iter',40,'torr',0.001);
 example: [IDX,IDY,~,~,~,proX,proY]=exe_co_evol_nmf(dmatrix,'cluster',20,'mu',0,'repli',20,'iter',40,'torr',0.001);
input:
A: matrix of data m*n
cluster: number of cluster
mu: alpha=0 is pure co-clustering
repli: repeat computing times
iter: number of iterations
torr: when the errors are very very small, the algorithm stops


output: 

IDX and IDY are the row and column indicator cluster matrices

ierr: index error

ferr: feature error
  
