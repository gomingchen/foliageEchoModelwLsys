
%%% Plot pine needles

function  lfvec = PineNeedle2_line(N, ang, L, ChildB, BTip, R0)
%Inputs: N, the number of needles at one tip
%        ang, the angle between the child branch and each needle, elevation
%        angle
%        R0, the radius of each needle (cylinder), LineWidth in line
%        function
%        L, the length of each needle (cylinder)
%        ChildB, the branch of g branch, [u v w]
%        Btip, The tip coordinates of 'g' branch, [newxT, newyT, newzT]

%%% First get the sph coordinates of the end tips of the needles, assuming
%%% the needles sprout from origin

el = 90 - ang;
az = (0:(N-1))*13/34*360;
%%% needle vectors
[x,y,z] = sph2cart(deg2rad(az'), deg2rad(el)*ones(N,1), L*ones(N,1));
%%% needle endpoints
% NeedleEnd = [zeros(N,1), zeros(N,1), linspace(-4.5E-2, 0, N)'];
% NeedleTip = [x, y, z] + NeedleEnd;
NeedleVec = [x, y, z];

% Get the rotation matrix to rotate z axis to the g child branch direction
% The first three elements specify the rotation axis, and the last element defines the angle of rotation.
r = vrrotvec([0 0 1],ChildB);

UnitNeedleVec = NeedleVec./repmat(sqrt(x.^2 + y.^2 + z.^2), 1, 3);
rotatedUnitVec = rotVecAroundArbAxis(UnitNeedleVec, r(1:3), rad2deg(r(4)));

NewNeedleVec = L*rotatedUnitVec; %%% + repmat(BTip, N, 1)

% UnitNeedleEnd = repmat([0,0,1],N,1);
% RotatedUnitEnd = rotVecAroundArbAxis(UnitNeedleEnd, r(1:3), rad2deg(r(4)));

%BundleVec = NewNeedleTip - repmat(BTip, N, 1);
NewNeedleEnd = repmat(BTip, N, 1) - linspace(0, 4.5E-2 - 4.5E-2/N, N)'/sqrt(ChildB(1)^2 + ChildB(2)^2 + ChildB(3)^2)*ChildB;
NewNeedleTip = NewNeedleEnd + NewNeedleVec;
lfvec = [NewNeedleTip NewNeedleVec];
color = [83/255, 132/255, 10/255];

for i = 1:N
    hold on
    %cylinder2P_needle(R0, 10, [NewNeedleEnd(i,1) NewNeedleEnd(i,2) NewNeedleEnd(i,3)] , [NewNeedleTip(i,1) NewNeedleTip(i,2) NewNeedleTip(i,3)]);
    line([NewNeedleEnd(i,1) NewNeedleTip(i,1)], [NewNeedleEnd(i,2),NewNeedleTip(i,2)], [NewNeedleEnd(i,3),NewNeedleTip(i,3)], 'Color', color, 'LineWidth', R0);
end

end



