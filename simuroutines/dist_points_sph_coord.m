function [deltaR] = dist_points_sph_coord(r1,theta1,phi1,r2,theta2,phi2)
% DIST_POINTS_SPH_COORD: FInd distance between two points in spherical
%coordinates
% Created by: Anupam Kumar Gupta, Date: 02/24/2015

x1 = r1 .* cos(phi1) .* cos(theta1);
x2 = r2 .* cos(phi2) .* cos(theta2);
y1 = r1 .* cos(phi1) .* sin(theta1);
y2 = r2 .* cos(phi2) .* sin(theta2);
z1 = r1 .* sin(phi1);
z2 = r2 .* sin(phi2);

X = [x1 x2];
Y = [y1 y2];
Z = [z1 z2];

deltaR = sqrt((((diff(X,1,2)).^2) + ((diff(Y,1,2)).^2) + ((diff(Z,1,2)).^2)));
% deltaR = sqrt((x1 - x2)^2 + (y1 - y2)^2 + (z1 - z2)^2);

% deltaR = sqrt(r1^2 + r2^2 + - 2*r1*r2*((sin(phi1)*sin(phi2)*cos(theta1-theta2))+ (cos(phi1)*cos(phi2))));

end

