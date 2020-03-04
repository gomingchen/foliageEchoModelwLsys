% This code is to describe the scattering of the leaves
% Inputs: frequency of incoming wave from the sonar, frq 60~80 (kHz)
%         radius of the leaf, a
%         incident angle, theta0, in radians
%         the number of bins between 60~80kHz, no_bins
% Outputs: 
%          amplitude of the leaf beampattern, leaf_amp
%          phase of the leaf beampattern, leaf_phase
% Created by Chen Ming, Date: 06/01/2015

function [leaf_amp, leaf_phase] = leaf_beampattern(frq, a, theta0, no_bins)


%%% Amplitude of the leaf beampatterns
speed = 340;
lambda = speed./(frq*1E3);
k = 2*pi./lambda;
c = k'*a(:)';


theta = repmat(transpose(theta0(:)),no_bins,1);
pbc = 2.6343;

Ac = 0.5003*c.^2 + 0.6867;

bc = 0.3999*c.^(-0.9065) +0.9979;
leaf_amp = Ac.*cos(bc.*theta);
pac = 0.9824*c.^0.3523 - 0.9459;
leaf_phase = erf(pac.*(1.57-theta)) - pbc;
toc;
leaf_amp(leaf_amp < 0) = 0;

%%% Phase of the leaf beampattern

% pac = 0.9824*power(c,0.3523)-0.9459;

 % pac is a(c), pbc is b(c), which both describes the phase of the leaf beam pattern
end



