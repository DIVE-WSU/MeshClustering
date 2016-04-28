%Daming Feng
%04/10/2013

function bAngles=GetAngles(bCoords,L)
%calculate all the angles of the up half of ellipse,
%the # of angles is the # of bCoords minus one

for i=1:size(bCoords,1)-1
    len1=norm(bCoords(i,:));
    len2=norm(bCoords(i+1,:));
    cos_t=(len2^2+len1^2-L^2)/(2*len2*len1);
    t=acos(cos_t);
    bAngles(1,i)=t;
end

