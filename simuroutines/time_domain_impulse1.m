% Inputs: 
%         SONAR:
%         amp, max amplitude
%         sonar_input_type, should be either 'incident_freq' or beamwidth
%         sonar_input_value, the value of corresponding type
%         
%         LEAF:
%         no_leaf, number of leaves  
%         (r_leaf; theta_leaf; phi_leaf), spherical coordinates of the leaves
%         inci_sup, incident angle which could be a single value or a
%                   range. If the input is a single value, then the range
%                   will be [0 input]
%         size_sup, leaf size which could be a single value or a range. But
%                   when input is a single value, leaves will have the same
%                   size as the value
% Outputs:
%         impulse, the echo
%         Created by Chen Ming, Date: 06/01/2015
function impulse = time_domain_impulse1(Sonargain,R_sonar_leaf,leaf_dia,Incident_angles,echo_param)

a = leaf_dia(:);
theta0 = Incident_angles(:);
Fs = echo_param.Fs; % sampling frequency (kHz)
N = echo_param.Nbins; % no of bins b/w 60-80 kHz

% sonar inputs
pre_frq_a = 60; % in kHz
pre_frq_b = 80; % in kHz


delta_f = (Fs/N); % the interval in frequency domain is 0.01kHz
n = N/2; % In frequency domain, there are n + 1 bins.


no_bins = floor((pre_frq_b - pre_frq_a)/delta_f + 1); % Number of bins in the range that we are interested

w = hann(no_bins,'periodic'); % Apply a hanning window in frequency domain from 60kHz to 80kHz
w = repmat(w, 1, length(R_sonar_leaf(:)));


frq = pre_frq_a: delta_f :pre_frq_b;
[total_amp, total_phase] = get_echoes1(frq,a,theta0,no_bins,Sonargain(:),R_sonar_leaf(:));

ReX = total_amp.*cos(total_phase).*w;
ImX = total_amp.*sin(total_phase).*w;

% total ReX and ImX of all leaves
t_R = sum(ReX,2);
t_I = sum(ImX,2);


% add zeros in two ends of t_R and t_I
t_R = [zeros(1,floor(pre_frq_a/delta_f)), t_R', zeros(1,floor((Fs/2 - pre_frq_b)/delta_f))];
t_I = [zeros(1,floor(pre_frq_a/delta_f)), t_I', zeros(1,floor((Fs/2 - pre_frq_b)/delta_f))];

REX = t_R; 
IMX = t_I;


for jj = n+2:N
    REX(jj) =  REX(N+2 -jj);
    IMX(jj) = -IMX(N+2 -jj);
end

XX = REX + 1i*IMX;
xx = ifft(XX);

% Here, there is an amplitude correction for hanning window function 2. For energy correction, the factor is sqrt(8/3);
impulse = 2.*xx; % Compensate for hanning window
% time = R_sonar_leaf(:).*2/340*1E3; % in ms
% % sstore the results
% s = struct();
% s.leaf = struct();
% s.leaf.incident_angle = theta0; % in degrees
% s.leaf.size = a; % in m
% s.leaf.distance = R_sonar_leaf(:);
% 
% s.time_domain = struct();
% s.time_domain.sampling_rate = Fs;
% s.time_domain.no_samples = N;
% s.time_domain.impulse = impulse;
% s.time_domain.time = time;
% s.frq_domain = struct();
% s.frq_domain.real = REX;
% s.frq_domain.imag = IMX;
% s.frq_domain.mag = sqrt(REX.^2 + IMX.^2);
end

