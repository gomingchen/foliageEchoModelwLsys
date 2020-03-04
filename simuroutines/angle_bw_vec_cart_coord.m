function [ theta ] = angle_bw_vec_cart_coord(Vec1,Vec2)
% ANGLE_VEC_SPH_COORD: Find angle between vectors(single or 2D arrays) in spherical coordinate
% system by converting to cartesian coordinates and translating to origin.
% Created by: Anupam Kumar Gupta, Date: 02/25/2015

A = Vec1;
B = Vec2;

ABdot = dot(A,B,2); % dot product between two vectors
ABcross = cross(A,B,2); % cross product between two vectors

ABcross_mag = sqrt(sum((ABcross.^2),2));

theta = atan2d(ABcross_mag,ABdot); % angle between two vectors


end

