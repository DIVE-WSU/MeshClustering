%Daming Feng
%04/13/2013

function FillColors(newCoords,tris,ave_a,ave_b)


    colors=[[1 1 0]; [1 0 1]; [0 1 1]; [1 0 0]; [0 1 0]; 
            [0 0 1]; [1 1 1]; [1 0.4 0.6]; [1 0.6 0.4]; [0.6 1 0.4]; 
            [0.6 0.4 1]; [0.0 0.8 0.7]; [0.6 0.4 1]; [1 0.7 0.3]; [1 0.7 0.3];
            [0.7 0.3 1]; [0.3 0.7 1]; [0.3 1 0.7]; [0.7 1 0.3]; [1 0.7 0.3];
            [1 0.7 0.3]; [0.8 0.2 1]; [0.2 0.8 1]; [0.2 1 0.8]; [0.8 1 0.2];
            [1 0.8 0.2]; [1 0.8 0.2]; [0.9 0.1 1]; [0.1 0.9 1]; [0.1 1 0.9]; 
            [0.9 1 0.1]; [1 0.9 0.1]; [1 0.9 0.1]; [0.0 0.7 0.8]; [0.7 0 0.8];
            [0.6 0 0.9]; [0.9 0 0.6]; [1 0.5 0]; [0.5 0.7 1.0]; [0.3 0 0.2]];

      
[newCoords,tris,nt]=MeshOnAveEllipse();        

    size_of_tris=size(tris,1);
    for i = 1 : size(tris,1);
       t = tris(i, :);
       xxx=[newCoords(t(1),1) newCoords(t(2),1) newCoords(t(3),1)];
       yyy=[newCoords(t(1),2) newCoords(t(2),2) newCoords(t(3),2)];
       fill(xxx, yyy,'r');
       text(sum(xxx)/3, sum(yyy)/3, '1','VerticalAlignment','middle',...
            'HorizontalAlignment','center', 'FontSize',6);
       hold on;   
    end
    
   end
  
