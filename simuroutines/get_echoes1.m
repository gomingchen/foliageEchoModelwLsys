% This program is to produce echoes from leaves
% Inputs: 
%         frequency of the incident wave, frq, in kHz.
%
%         % LEAF INPUTS:
%         a, radius of the leaf
%         theta0, incident angle
%
%         % SONAR INPUTS:
%         Frequency varies b/w 60~80 kHz or beamwidth required.
%         no_bins, the number of bins in our interesting frequency range (60kHz, 80kHz)
% Outputs:
%         total_amp & total_phase, another interpretation of frequency domain

function [total_amp, total_phase] = get_echoes1(frq,a,theta0, no_bins,Sonargain,R_sonar_leaf)

%%% Calculate the total gain

% leaf beam patterns

[leaf_amp, leaf_phase] = leaf_beampattern( frq, a, theta0, no_bins);

%%% Uncomment this if you want to adopt mex file, and at the same time,
%%% comment  [leaf_amp, leaf_phase] = leaf_beampattern( frq, a, theta0, no_bins);
% theta0 = transpose(theta0);
% a = transpose(a);
% [leafamp, lfphase] = leafbeamp(theta0,a);
% leaf_phase2 = erf(lfphase)-2.6343;
% interm = reshape(leafamp,[],1);
% fin = reshape(interm, length(a), 1201);
% leaf_amp = transpose(fin);
% 
% leaf_phase = transpose(reshape(reshape(leaf_phase2,[],1),length(a),1201));



% total amplitude gain
speed = 340;
lambda = speed./(frq*1E3);
k = 2*pi./lambda;
k = repmat(k',1,length(a));
dist_s_l = repmat(transpose(R_sonar_leaf(:)),no_bins,1);
sonar_gain = repmat(transpose(Sonargain(:)),no_bins,1);

total_amp = leaf_amp./(k).* sonar_gain.*0.2; %%%./dist_s_l.*dist_s_l
% size(total_amp)


%%% Calculate the total phase

total_phase = -2.*dist_s_l.*k - leaf_phase;

end