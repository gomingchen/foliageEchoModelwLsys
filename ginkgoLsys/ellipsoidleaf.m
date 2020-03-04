function ellipsoidleaf(xc,yc,zc,rx,ry,rz,n,thetax,thetay,thetaz)
%ELLIpsoidLeaf: Makes ellipsoid leaf
%xc,yc,zc: coordinates of leaf center
%rx,ry,rz: radius in x,y &z directions
%n: no of elements to discretize the ellipsoid into
%thetax,thetay,thetaz: rotation angles across x,y & z directions
%Created by:Anupam Kumar Gupta,Date: 09/04/2014

%%% Make ellipsoid
[xs,ys,zs] = sphere(n);
%Scale the sphere coordinates with radii to get ellipsoid
x = rx*xs;
y = ry*ys;
z = rz*zs;

thetax = deg2rad(thetax);
thetay = deg2rad(thetay);
thetaz = deg2rad(thetaz);

%%%Rotation matrices
Rx = [1 0 0;0 cos(thetax) -sin(thetax);0 sin(thetax) cos(thetax)];
Ry = [cos(thetay) 0 sin(thetay);0 1 0;-sin(thetay) 0 cos(thetay)];
Rz = [cos(thetaz) -sin(thetaz) 0;sin(thetaz) cos(thetaz) 0;0 0 1];

R = Rz*Ry*Rx;%overall rotation matrices
newxyz = [x(:) y(:) z(:)];
newxyz = newxyz*R;
[m,n] = size(x);
newx = xc + reshape(newxyz(:,1),m,n);
newy = yc + reshape(newxyz(:,2),m,n);
newz = zc + reshape(newxyz(:,3),m,n);

C(:,:,1) = zeros(31,31);
C(:,:,2) = 0.8*ones(31,31);
C(:,:,3) = zeros(31,31);

surf(newx,newy,newz,C, 'EdgeColor','none');

end