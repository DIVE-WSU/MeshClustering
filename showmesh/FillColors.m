% function FillColors
% Daming Feng
% dmfeng8898@gmail.com

function FillColors(num,path1)

    colors=[[1 1 0]; [1 0 1]; [0 1 1]; [1 0 0]; [0 1 0]; 
            [0 0 1]; [1 1 1]; [1 0.4 0.6]; [1 0.6 0.4]; [0.6 1 0.4]; 
            [0.6 0.4 1]; [0.0 0.8 0.7]; [0.6 0.4 1]; [1 0.7 0.3]; [1 0.7 0.3];
            [0.7 0.3 1]; [0.3 0.7 1]; [0.3 1 0.7]; [0.7 1 0.3]; [1 0.7 0.3];
            [1 0.7 0.3]; [0.8 0.2 1]; [0.2 0.8 1]; [0.2 1 0.8]; [0.8 1 0.2];
            [1 0.8 0.2]; [1 0.8 0.2]; [0.9 0.1 1]; [0.1 0.9 1]; [0.1 1 0.9]; 
            [0.9 1 0.1]; [1 0.9 0.1]; [1 0.9 0.1]; [0.0 0.7 0.8]; [0.7 0 0.8];
            [0.6 0 0.9]; [0.9 0 0.6]; [1 0.5 0]; [0.5 0.7 1.0]; [0.3 0 0.2]];

  s=load(strcat(path1,'newCoords.mat'));
  newCoords=s.newCoords; 
        
  for j=1:num
    x=load(strcat(path1,'t',int2str(j),'.mat'));
    t=strcat('t',int2str(j));
    y=x.(t);
    for i = 1 : size(y,1)
       t = y(i, :);
       xxx=[newCoords(t(1),1) newCoords(t(2),1) newCoords(t(3),1)];
       yyy=[newCoords(t(1),2) newCoords(t(2),2) newCoords(t(3),2)];
       fill(xxx, yyy,colors(j,:));
       text(sum(xxx)/3, sum(yyy)/3, num2str(j),'VerticalAlignment','middle',...
           'HorizontalAlignment','center', 'FontSize',6);
      hold on;
    end
  end

