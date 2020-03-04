% plot beampattern with L-system trees
% Created by Chen Ming, Date: 11/01/2016

function waterdrop_sonarbeam(sonar_loc, boxcenter, freqorbmwdthVal)

xs = sonar_loc(1);
ys = sonar_loc(2);
zs = sonar_loc(3);

Vecbeam = boxcenter - sonar_loc;
[TH_beam, PHI_beam, ~] = cart2sph(Vecbeam(1), Vecbeam(2), Vecbeam(3));

N = 500;
freqorbmwdth = 'beamwidth';
%freqorbmwdthVal = 10;% beamwidth in degrees (elevation and azimuth same)
sigma_x = predict_gauss_sigma(freqorbmwdth,freqorbmwdthVal); % get sigma for beamwidth corresponding to frequency of incidence
sigma_y = predict_gauss_sigma(freqorbmwdth,freqorbmwdthVal); % get sigma for beamwidth corresponding to frequency of incidence
x0 = TH_beam;
y0 = PHI_beam;
[az, el] = meshgrid(linspace(x0-pi/2,x0+pi/2,N), linspace(y0-pi/2,y0+pi/2,N));

theta = 0;
A = 1;

hold on
dB = 20;
r0 = 0.1;

a = ((cos(theta))^2)/(2*(sigma_x^2)) + ((sin(theta))^2)/(2*(sigma_y)^2);
b = (-sin(2*theta))/(4*(sigma_x)^2) + (sin(2*theta))/(4*(sigma_y)^2);
c = ((sin(theta))^2)/(2*(sigma_x)^2) + ((cos(theta))^2)/(2*(sigma_y)^2);
    
   %Z = A*exp( -((a*(X-x0).^2) + (2*b*(X-x0).*(Y-y0)) + (c*(Y-y0).^2)));
Z = A*exp(-((a*(az-x0).^2) + (2*b*(az-x0).*(el-y0)) + (c*(el-y0).^2)));

%sonarbp = exp(-( az - az_mean ).^2./2./gauss_sigma^2);
RX_square = 10^(-dB/20)*r0^2*1E5*(Z).^2;%
RX = sqrt(RX_square);

%idxfilter = find(R_sonar_leaf <= dis_b); %find the index where gain is greater than threshold

%%% Extract leaves & parameters that pass gain threshld
% TH_leaf_filt = TH_leaf(idxfilter);
% PHI_leaf_filt = PHI_leaf(idxfilter);
% R_leaf_filt = R_leaf(idxfilter);

x = xs + RX.*cos(el).*cos(az);
y = ys + RX.*cos(el).*sin(az);
z = zs + RX.*sin(el);
hSurface = surf(x,y,z,'EdgeColor','none','FaceLighting','phong');
set(hSurface,'FaceColor','r','FaceAlpha',0.2);
%camlight; lighting gouraud;
hold on, scatter3(xs, ys, zs, 'filled');
end

