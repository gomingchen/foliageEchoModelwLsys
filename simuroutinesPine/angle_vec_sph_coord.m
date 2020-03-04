function [ deltatheta ] = angle_vec_sph_coord(Vec1,Vec2)
% ANGLE_VEC_SPH_COORD: Find angle between vectors in spherical coordinate
% system by converting to cartesian coordinates and translating to origin.
% Created by: Anupam Kumar Gupta, Date: 02/25/2015

R_sonar = Vec1(:,1);
R_leaf = Vec1(:,4);
R_leaf_norm = Vec2(:,1);

TH_sonar = Vec1(:,2);
TH_leaf = Vec1(:,5);
TH_leaf_norm = Vec2(:,2);

PHI_sonar = Vec1(:,3);
PHI_leaf = Vec1(:,6);
PHI_leaf_norm = Vec2(:,3);

x1_strt = R_sonar .* cos(PHI_sonar) .* cos(TH_sonar);
x1_end =  R_leaf .* cos(PHI_leaf) .* cos(TH_leaf);

x2_end = R_leaf_norm .* cos(PHI_leaf_norm) .* cos(TH_leaf_norm);
x2_strt = zeros(size(R_leaf,1),1);


y1_strt = R_sonar .* cos(PHI_sonar) .* sin(TH_sonar);
y1_end = R_leaf .* cos(PHI_leaf) .* sin(TH_leaf);
y2_strt = zeros(size(R_leaf,1),1);
y2_end = R_leaf_norm .* cos(PHI_leaf_norm) .* sin(TH_leaf_norm);

z1_strt = R_sonar .* sin(PHI_sonar);
z1_end = R_leaf .* sin(PHI_leaf);
z2_strt = zeros(size(R_leaf,1),1);
z2_end = R_leaf_norm .* sin(PHI_leaf_norm);

A_strt = [x1_strt y1_strt z1_strt];
A_end = [x1_end y1_end z1_end];

B_strt = [x2_strt y2_strt z2_strt];
B_end = [x2_end y2_end z2_end];

A = A_end - A_strt;
B = B_end - B_strt;


ABdot = dot(A,B,2); % dot product between two vectors
ABcross = cross(A,B,2); % cross product between two vectors

ABcross_mag = sqrt(sum(ABcross.^2,2));

deltatheta =(abs(atan2(ABcross_mag,ABdot))); % angle between two vectors
indxanglegrt90 = find(deltatheta > pi/2);
deltatheta(indxanglegrt90) = pi - deltatheta(indxanglegrt90);

end

