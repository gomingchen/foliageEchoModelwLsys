
%%% Plot pine needles

function  lfvec = PineNeedle(N, ang, L, ChildB, BTip, R0)
%Inputs: N, the number of needles at one tip
%        ang, the angle between the child branch and each needle, elevation
%        angle
%        R0, the radius of each needle (cylinder)
%        L, the length of each needle (cylinder)
%        ChildB, the branch of g branch, [u v w]
%        Btip, The tip coordinates of 'g' branch, [newxT, newyT, newzT]

%%% First get the sph coordinates of the end tips of the needles, assuming
%%% the needles sprout from origin

el = 90 - ang;
az = linspace(0, 360-360/N, N);
[x,y,z] = sph2cart(deg2rad(az'), deg2rad(el)*ones(N,1), L*ones(N,1));
NeedleTip = [x, y, z];

% Get the rotation matrix to rotate z axis to the g child branch direction
% The first three elements specify the rotation axis, and the last element defines the angle of rotation.
r = vrrotvec([0 0 1],ChildB);

UnitNeedleTip = NeedleTip./repmat(sqrt(x.^2 + y.^2 + z.^2), 1, 3);
rotatedUnitVector = rotVecAroundArbAxis(UnitNeedleTip, r(1:3), rad2deg(r(4)));

NewNeedleTip = L*rotatedUnitVector + repmat(BTip, N, 1);

BundleVec = NewNeedleTip - repmat(BTip, N, 1);
lfvec = [NewNeedleTip BundleVec];
for i = 1:N
    hold on
    cylinder2P_needle(R0, 10, BTip , [NewNeedleTip(i,1) NewNeedleTip(i,2) NewNeedleTip(i,3)]);
end

end



