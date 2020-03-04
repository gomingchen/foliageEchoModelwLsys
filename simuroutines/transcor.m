function [Sphcoord_sonar, Sphcoord_leaf, beamcenter] = transcor(sonar_loc, boxcenter, xleafloc, yleafloc, zleafloc)
% Transfer the leaf center positions and 
%%% Sonar location
% Created by Chen Ming, Date: 01/05/2017
if (length(sonar_loc) == 3)
    
    x_sonar = sonar_loc(1);
    y_sonar = sonar_loc(2);
    z_sonar = sonar_loc(3);
else
    error('Wrong input');
end

%%% Translate the coordinate system origin to sonar center
x_sonartrans = x_sonar - x_sonar;
y_sonartrans = y_sonar - y_sonar;
z_sonartrans = z_sonar - z_sonar;
n_leaf = length(xleafloc);

LeafcenM = [xleafloc(:) yleafloc(:) zleafloc(:)];
Transmatrix = repmat([-x_sonar -y_sonar -z_sonar],n_leaf,1);
Leafcentrans = LeafcenM+Transmatrix; % Transmatrix is 0 matrix here.


% Convert the leaf, leaf surface normals & sonar coordinates from cartesian to spherical
[TH_leaf_sonar,PHI_leaf_sonar,R_leaf_sonar] = cart2sph([Leafcentrans(:,1);x_sonartrans],[Leafcentrans(:,2);y_sonartrans],[Leafcentrans(:,3);z_sonartrans]);


%%% Leaf
TH_leaf = TH_leaf_sonar(1:end-1);
PHI_leaf = PHI_leaf_sonar(1:end-1);
R_leaf = R_leaf_sonar(1:end-1);


% PHI_leaf_norm = deg2rad(90 - PHI_leaf_norm); % PHI_leaf_norm are elevation angles starting from xy plane. 
%When sampling from beta distribution, the inclination angle is the one between leaf surface and xy plane. To obtain the angle between leaf normal and xy plane, we should use 90 to deduct the previous one.

%%% Sonar
TH_sonar = TH_leaf_sonar(end);
PHI_sonar = PHI_leaf_sonar(end);
R_sonar = R_leaf_sonar(end);

%%% Outputs
Sphcoord_leaf= [TH_leaf(:) PHI_leaf(:) R_leaf(:)];
Sphcoord_sonar = [TH_sonar PHI_sonar R_sonar];
Vecbeam = boxcenter - sonar_loc;
[TH_beam, PHI_beam, ~] = cart2sph(Vecbeam(1), Vecbeam(2), Vecbeam(3));
beamcenter = [TH_beam, PHI_beam];
end
