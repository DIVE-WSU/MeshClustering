%Function PlotEllipse
%Daming Feng
%04/11/2013

function PlotEllipse(a,b,X0,Y0,phi,color)

theta_r = linspace(0,2*pi);
ellipse_x_r     = a*cos( theta_r );
ellipse_y_r     = b*sin( theta_r );
R=[cos(phi) -sin(phi);sin(phi) cos(phi)];

rotated_ellipse = R * [ellipse_x_r;ellipse_y_r];
plot( rotated_ellipse(1,:)+X0,rotated_ellipse(2,:)+Y0,color);
