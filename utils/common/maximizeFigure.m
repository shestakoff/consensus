function fig = maximizeFigure(fig)
% Original author: Bill Finger, Creare Inc. 
if nargin==0 
  fig=gcf; 
end
units=get(fig,'units');
set(fig,'units','normalized','outerposition',[0 0 1 1]);
set(fig,'units',units);
return