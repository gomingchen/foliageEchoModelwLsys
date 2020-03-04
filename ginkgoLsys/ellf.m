
function ellf(xc, yc, zc, vx, vy, vz)
% Plot four leaves whose center is [xc, yc, zc] and normal vector is [vx,
% vy, vz]
n = 10;
xr = 5E-2;
yr = 5E-2;
zr = 1E-3;

[x,y,z] = ellipsoid(0,0,0,xr,yr,zr,n);

r = vrrotvec([0 0 1],[vx vy vz]);
[q, Norm] = arb2uni([x(:) y(:) z(:)]);
rAU = arb2uni(r(1:3));
rAU = repmat(rAU, length(x(:)), 1);
theta = rad2deg(r(4))*ones(length(x(:)),1);


newXYZ = rotVecAroundArbAxis(q, rAU, theta);

or = uniback( newXYZ, Norm);

[m,n] = size(x);
xx = reshape(or(:,1),m,n);
yy = reshape(or(:,2),m,n);
zz = reshape(or(:,3),m,n);
newx = xc + xx;
newy = yc + yy;
newz = zc + zz;


C(:,:,1) = zeros(31,31);
C(:,:,2) = 0.8*ones(31,31);
C(:,:,3) = zeros(31,31);
hs = surf(newx, newy, newz, C, 'EdgeColor','none');
leafgreen = [58/255, 95/255, 11/255];
set(hs, 'FaceColor', leafgreen);
end