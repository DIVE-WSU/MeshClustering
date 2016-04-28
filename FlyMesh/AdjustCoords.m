%Daming Feng
%04/11/2013

% a and b respect to the specific ellipse
% return coords is a colum vector
function [transCoords]=AdjustCoords(x0,y0,bAngles,a,b,phi)

% this part is used to find all the inter points(start and end points are
% not included.
t=0;
num=size(bAngles,2)
for i=1:num-1
    %ttt=bAngles(1,i);
    t=t+bAngles(1,i);
    tan_t=tan(t);

        y=1/sqrt(1/(a*tan(t))^2+1/b^2);
        x=y/tan(t);

    scoords(i+1,1)=x;
    scoords(i+1,2)=y;
end

scoords(1,:)=[a 0];
scoords(size(scoords,1)+1,:)=[-a 0];
N=size(scoords,1)-1;

for i=N:-1:2
   opp=[scoords(i,1),-scoords(i,2)];
   j=N-i+1;
   scoords(N+1+j,:)=opp;
end

R=[cos(phi) -sin(phi);sin(phi) cos(phi)];
roatedCoords=scoords*R';
for i=1:size(roatedCoords,1)
    transCoords(i,:)=roatedCoords(i,:)+[x0 y0];
end

