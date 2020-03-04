

function [Rmat]=rotz(angle)
%%output: rotation matrix along Z axis by an angle expressed in degree
Rmat=[ cosd(angle) -sind(angle) 0 
       sind(angle) cosd(angle) 0;
       0  0  1];

end