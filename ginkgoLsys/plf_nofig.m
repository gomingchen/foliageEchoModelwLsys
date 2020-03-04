
function [lfin, NTIP] = plf_nofig(xT, yT, zT, u, v, w, s, N, M)
% xT, yT, zT are the starting point of the branch
% u, v, w are the three dimensional increment of the branch, which means 
% xT+u is the x value of the ending point of the branch
% N, how many leaves to plot in each multilf_normrot
% M, how many leaf nodes in this branch
% s, is the string that indicates how you would like the leaf normals
% perpendicular to the branch ('2') or parallel to it ('1')
% Created by Chen Ming, Date: 11/05/2016
g = 360/M;
lfin = [];
NTIP = zeros(M,3);

if length(s)~=M
    error('plf: the dimension of string input must equal to the number of leaf nodes, M');
end
for i = 1:M
    h = g*(i-1); 
    [leaf, NTIP(i,:)] = multilf_normrot(N, [xT+u*i/(M+1), yT+v*i/(M+1), zT+w*i/(M+1)], [u,v,w], s(i), h);
    lfin = [lfin;leaf];
end
end


function [lfinfo,Ntip] = multilf_normrot(N, C, Vec, s, gamma)

% To plot multiple leaves
% Inputs: N, the number of leaves one wants to plot
%         C, the center position of those leaves, 3*1
%         Vec, the leaf normal vector, 3*1
%         If s = '1', Vec is the leaf normal vector
%         If s = '2', Vec is the vector that is perpendicular to leaf's
%         normal vector
%         gamma, the angle that one wants to rotate along Vec (when s =
%         '2')
% Outputs: Ntip, the coordinates of each leaf node

            newxT = C(1);
            newyT = C(2);
            newzT = C(3);
            del = 0.1;
            D = 0.1;
            u = Vec(1); 
            v = Vec(2);
            w = Vec(3);
            lfinfo = zeros(N,6);
            Ntip = zeros(1,3);
            
switch s
    case '1'
            
            for tt = 1:N
                xc = newxT + del*rand(1);
                yc = newyT + del*rand(1);
                zc = newzT + 0.2*rand(1);
                %ellf(xc, yc, zc, u+D*rand(1), v+D*rand(1), w+D*rand(1));
                
            end
            Ntip = [newxT newyT newzT];
    case '2'
        
        v_perp = find_perp(Vec);
        v_perp_new = rotVecAroundArbAxis(v_perp/norm(v_perp),Vec/norm(Vec),gamma);
        VP = repmat(v_perp_new, N, 1);
        Axis = repmat(Vec/norm(Vec), N, 1);
        theta = zeros(N,1);
        for i = 1:N
            theta(i) = 10*(i-1);
        end
        %theta = [0;20;40;50];
        % rotatedUnitVector = rotVecAroundArbAxis(unitVec2Rotate,rotationAxisUnitVec,theta)
        M_perp = rotVecAroundArbAxis(VP, Axis, theta);
        for leafi = 1:N
 
           xc = newxT + del*rand*v_perp_new(1);
           yc = newyT + del*rand*v_perp_new(2);
           zc = newzT + del*rand*v_perp_new(3);
           lfinfo(leafi,:) = [xc yc zc M_perp(leafi,1) M_perp(leafi,2) M_perp(leafi,3)];
           %ellf(xc, yc, zc, M_perp(leafi,1), M_perp(leafi,2), M_perp(leafi,3));
           %hold on
        end
        Ntip = [newxT+del*v_perp_new(1)  newyT+del*v_perp_new(2)  newzT+del*v_perp_new(3)]; % del = 10cm
end    
end


% function ellf(xc, yc, zc, vx, vy, vz)
% % Plot four leaves whose center is [xc, yc, zc] and normal vector is [vx,
% % vy, vz]
% n = 10;
% xr = 5E-2;
% yr = 3E-2;
% zr = 1E-3;
% 
% [x,y,z] = ellipsoid(0,0,0,xr,yr,zr,n);
% 
% r = vrrotvec([0 0 1],[vx vy vz]);
% [q, Norm] = arb2uni([x(:) y(:) z(:)]);
% rAU = arb2uni(r(1:3));
% rAU = repmat(rAU, length(x(:)), 1);
% theta = rad2deg(r(4))*ones(length(x(:)),1);
% 
% 
% newXYZ = rotVecAroundArbAxis(q, rAU, theta);
% 
% or = uniback( newXYZ, Norm);
% 
% [m,n] = size(x);
% xx = reshape(or(:,1),m,n);
% yy = reshape(or(:,2),m,n);
% zz = reshape(or(:,3),m,n);
% newx = xc + xx;
% newy = yc + yy;
% newz = zc + zz;
% 
% C(:,:,1) = zeros(31,31);
% C(:,:,2) = 0.8*ones(31,31);
% C(:,:,3) = zeros(31,31);
% hs = surf(newx, newy, newz, C, 'EdgeColor','none');
% grey = [0.4 0.4 0.4];
% set(hs, 'FaceColor', grey); % [58/255, 95/255, 11/255]
% end