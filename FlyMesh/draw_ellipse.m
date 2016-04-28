
clear all;
close all;
axis equal;
hold on;
    a=4;
    b=3;
    L=0.5;
    phi=pi/3;
theta_r = linspace(0,2*pi);

    ellipse_x_r     = a*cos(theta_r);
    ellipse_y_r     = b*sin(theta_r);
    plot(ellipse_x_r,ellipse_y_r,'k' );
    hold on;
    

    [L,bCoords]=FindBoundaryPoint(a,b,L);% bCoords is column vector
    %[A C]=MinVolEllipse(bCoords,0.01);
    bAngles=GetAngles(bCoords,L); %aAngle is a raw vector
    ellipse_x_r     = 6*cos(theta_r);
    ellipse_y_r     = 4*sin(theta_r);
    plot(ellipse_x_r,ellipse_y_r,'k' );
    hold on;
    
    R=[cos(phi) -sin(phi);sin(phi) cos(phi)];
    ellipse_x_r     = 6*cos(theta_r);
    ellipse_y_r     = 4*sin(theta_r);
    rotated_ellipse = R * [ellipse_x_r;ellipse_y_r];
    plot( rotated_ellipse(1,:),rotated_ellipse(2,:),'m' );
    hold on;
    
    ellipse_x_r     = 6*cos(theta_r);
    ellipse_y_r     = 4*sin(theta_r);
    rotated_ellipse = R * [ellipse_x_r;ellipse_y_r];
    plot( rotated_ellipse(1,:)+1,rotated_ellipse(2,:)+2,'m' );
    hold on;
    
     [transCoords,roatedCoords,coords]=AdjustCoords(1,2,bAngles,6,4,phi)

     plot(bCoords(:,1),bCoords(:,2),'*r' );

     plot(coords(:,1),coords(:,2),'*b' );
     plot(roatedCoords(:,1),roatedCoords(:,2),'*g' );
     plot(transCoords(:,1),transCoords(:,2),'*c' );
