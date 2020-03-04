function multilf(N, C, Vec, s)

% To plot multiple leaves
% Inputs: N, the number of leaves one wants to plot
%         C, the center position of those leaves, 3*1
%         Vec, the leaf normal vector, 3*1
%         If s = '1', Vec is the leaf normal vector
%         If s = '2', Vec is the vector that is perpendicular to leaf's
%         normal vector
% Created by Chen Ming, Date: 11/05/2016
            newxT = C(1);
            newyT = C(2);
            newzT = C(3);
            del = 0.05;
            D = 0.1;
            u = Vec(1);
            v = Vec(2);
            w = Vec(3);
            
switch s
    case '1'
            
            for tt = 1:N
                xc = newxT + del*rand(1);
                yc = newyT + del*rand(1);
                zc = newzT + 0.2*rand(1);
                ellf(xc, yc, zc, u+D*rand(1), v+D*rand(1), w+D*rand(1));
            end
    case '2'
        
        v_perp = find_perp(Vec);       
        VP = repmat(v_perp, N, 1);
        Axis = repmat(Vec/norm(Vec), N, 1);
        theta = [0;20;40;50];
        M_perp = rotVecAroundArbAxis(VP, Axis, theta);
        for leafi = 1:N
           xc = newxT + del*rand(1);
           yc = newyT + del*rand(1);
           zc = newzT + 0.2*rand(1);
           ellf(xc, yc, zc, M_perp(leafi,1), M_perp(leafi,2), M_perp(leafi,3));
        end
end
         
end


function ellf(xc, yc, zc, vx, vy, vz)
% Plot four leaves whose center is [xc, yc, zc] and normal vector is [vx,
% vy, vz]
n = 30;
xr = 5E-2;
yr = 3E-2;
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
set(hs, 'FaceColor', [58/255, 95/255, 11/255]);


end