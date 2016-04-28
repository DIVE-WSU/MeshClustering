FlyMesh software
Version 1.0
Written by: Daming Feng dfeng@cs.odu.edu   June 19 2013

copyright: Old Dominion University CS Department

Step 1: Unpacking the Archive
The package contains the source code of our image-to-mesh generation software and some appropriate test image. 


Step 2: Build the trianglulator.
We use "Triangle", a two-dimensional quality Delaunay triangulator as the basic triangulator of our image-to-mesh generation software.

cd to the directory "/Some Directory of your unpack file/I2MGenerator" to type the following command:

$ make distclean
$ make

After this step, you will see a binary "triangle" in the directory. Open the file "MeshEllipse.m", change the variable "path" to the directory that you just build the triangulator. Now, the triangulator is ready to use.

Step 3: Run the file "run.m" in Matlab

The variable "area" in file "imageBoundaryMesh.m" represents the upper area bound of triangles in mesh. Through changing the value of this variable, we can change the number of triangles in our mesh.


We also list some test images. You can use our function to test the mesh results. For example, if you want to show different triangles in mesh, such as # of triangles is 300, we can set the variable "area" to 93; # of triangle is about 800, set the "area" as 32. The result is shown in "57422_meshResult.fig" which has about the 300 triangles and so on.


