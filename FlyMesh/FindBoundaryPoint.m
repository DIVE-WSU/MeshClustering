%Daming Feng
%04/10/2013

function [L,bCoords,Allcoords]=FindBoundaryPoint(a,b,area)
%calculate the upper half points set including start and end points

%area=sqrt(3)/4*L^2;
L=2*sqrt(area)/sqrt(sqrt(3));

    n=1;
    startP=[a 0];
    endP=[-a,0];
    bCoords(1,:)=startP; 
    while norm(startP-endP)>=L
        n=n+1;
        newPoint=FindPoint(L, a, b, startP, 0.001);
           bCoords(n,:)=newPoint;
           startP=newPoint;
    end
    
    % adjust the length of L and find new point set
    LL=norm(startP-endP);
    insertNum=n;

    if LL<L/2
        n=n-1;
        L=L+LL/n;
        
        n=1;
        startP=[a 0];
        endP=[-a,0];
        bCoords = [];%zeros(np, 2);
        while norm(startP-endP)>=L
            n=n+1;
            newPoint=FindPoint(L, a, b, startP, 0.001);
           if n<insertNum
              bCoords(n,:)=newPoint;
           end
           startP=newPoint;
        end
    else
        L=L-(L-LL)/n;
        
        n=1;
        startP=[a 0];
        endP=[-a,0];
        bCoords = [];%zeros(np, 2);
        while norm(startP-endP)>=L
            n=n+1;
            newPoint=FindPoint(L, a, b, startP, 0.001);
            if n<=insertNum
               bCoords(n,:)=newPoint;
            end
            startP=newPoint;
        end
    end

     % add start and end point
     bCoords(1,:)=[a 0];
     newN=size(bCoords,1);
     n=newN+1;
     bCoords(n,:)=[-a,0];
     
     Allcoords=bCoords;
     for i=n-1:-1:2
        opp=[Allcoords(i,1),-Allcoords(i,2)];
        %j=n-1-i+1;
        Allcoords(2*n-i,:)=opp;
     end
