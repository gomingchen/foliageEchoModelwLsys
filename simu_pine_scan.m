%%% simu_Lsys_scan: Run the leaf scattering simulation with branching
%%% patterns constructed by L-system model and record echoes, scanning the
%%% tree from looking to the side to looking directly to the tree center
%Created by: Chen Ming, Date:11/01/2016
clc;clear;
addpath('simuroutinesPine'); % routines of calculating echoes
addpath('pineLsys'); % routines of constructing the L-system tree
leafsize = 0.2E-2; % in meter

%%% Leaf radii parameters
leaf_param.leafsize_dist = 'gauss';
leaf_param.leafsize_supp = leafsize; % leaf radius range in m
% the angle between x axis and leaf normal vector in degrees

%%% Sonar parameters
sonar_param.peakAmp = 1; % Peak amplitude of sonar beampattern
sonar_param.freqorbmwdth = 'beamwidth';
sonar_param.beamcenter = [0 0];% beam center coordinates
sonar_param.beam_rot = 0;% beam rotation/orientation
sonar_param.noise = [];

%%% Echo parameters
echo_param.Gthresh = 20; % gain value for thresholding (dB)
echo_param.Fs = 400; % sampling frequency (kHz)
echo_param.Nbins = 24E3; % no of bins b/w 60-80 kHz

nReps = 7; % Growth level of the pine tree

bwidth = 50; % sonar beamwidth
Rb = 1.5; % the length of initial branch
rx = 7; % x-coordinate of the sonar's location
ry = 0; % y-coordinate of the sonar's location
zs = 6; % z-coordinate of the sonar's location

V_alpha = -90:10:0; % the viewing angle from -90 degrees (looking to the side) to 0 degrees (sonar facing the tree center)
%V_alpha = 0;
y = zeros(length(V_alpha),echo_param.Nbins);
lfinBeam = zeros(length(V_alpha),1); % count number of leaves in sonar's beam

sonar_loc = [rx ry zs];
figure
for j = 1:length(V_alpha)
    hold on;
    j
    sonar_param.freqorbmwdthVal = bwidth;% beamwidth in degrees (elevation and azimuth same)
    freqorbmwdthVal = sonar_param.freqorbmwdthVal;
    beta = V_alpha(j); % in degrees;
    xs = rx - abs(rx)*cosd(beta);
    ys = ry + abs(rx)*sind(beta);

    
    boxcenter = [xs, ys, zs]; % the point the sonar is looking at
    
%%% Generate branch positions and each needle bundle position around 'g'
%%% tip
    [BR, lf, Gtip] = pine_GMT4(nReps, Rb);
    
%%% Superposition two trees together and get the matrix for 'g' tips
    newGtip = [Gtip; Gtip + length(Gtip)/30];
    SecondBR = zeros(size(BR,1), size(BR,2));
%%% Plot branches
    RotM = rotz(180);
    N = size(BR,1);
%%% Replicate the set of branches (by rotating 180 degrees) and add it to the original branches, to make a dense tree   
        for n = 1:N
        endrotated = RotM*BR(n, 2:4)';
        endrotated(3) = endrotated(3) + 0*Rb;
        tiprotated = RotM*BR(n, 5:7)';
        tiprotated(3) = tiprotated(3) + 0*Rb;
        cylinder2P(BR(n, 8), 10, BR(n, 2:4), BR(n, 5:7));
        cylinder2P(BR(n, 8), 10, endrotated', tiprotated');
        SecondBR(n,:) = [BR(n,1) endrotated' tiprotated' BR(n,8)];
        end
   newBR = [BR; SecondBR];

%%% Acquire echoes from the sonar beam
    treeBun2_loc = RotM*lf(:,1:3)';
    treeBun2_norm = RotM*lf(:,4:6)';
    newBun = [lf; [treeBun2_loc' treeBun2_norm']];
    n_leaf = 5*size(newBun, 1);
    xBunloc = newBun(:,1);
    yBunloc = newBun(:,2);
    zBunloc = newBun(:,3);
    Xlfnorm = repmat(newBun(:,4),5,1) + (-1 + 2*rand([n_leaf,1]))*5E-3;
    Ylfnorm = repmat(newBun(:,5),5,1) + (-1 + 2*rand([n_leaf,1]))*5E-3;
    Zlfnorm = repmat(newBun(:,6),5,1) + (-1 + 2*rand([n_leaf,1]))*5E-3;
   
    leaf_dia = lfsize_extract(leaf_param, n_leaf);

    R_leaf_norm = ones(n_leaf,1);
    [TH_leaf_norm, PHI_leaf_norm, ~] = cart2sph(Xlfnorm, Ylfnorm, Zlfnorm);
    Sphcoord_leafnorm.TH_leaf_norm = TH_leaf_norm;
    Sphcoord_leafnorm.PHI_leaf_norm = PHI_leaf_norm;
    Sphcoord_leafnorm.R_leaf_norm = R_leaf_norm;

    %%% Plot sonar beam
    hold on, waterdrop_sonarbeam(sonar_loc, boxcenter, freqorbmwdthVal);

    [Sphcoord_sonar, Sphcoord_leaf, beamcenter] = transcor(sonar_loc, boxcenter, xBunloc, yBunloc, zBunloc);
    [idxfilter, ~,~,R_sonar_leaf_filt,leaf_dia_filt,~,Sonargain_filt,Incident_angles] = filter_leaves_beamG(echo_param,Sphcoord_sonar,Sphcoord_leaf,Sphcoord_leafnorm,leaf_dia,sonar_param, beamcenter);
    imp = time_domain_impulse1(Sonargain_filt,R_sonar_leaf_filt,leaf_dia_filt,Incident_angles,echo_param);


    Num = 1:size(newBun,1);
    BundleNum = repmat(Num', 5, 1);
    RemainBundleNum = BundleNum(idxfilter);
    CountNum = unique(RemainBundleNum);
    lfinBeam(j) = length(idxfilter);
    shineG = newGtip(CountNum);
    CountGtip = unique(shineG);
    KG = find(newBR(:,1) == 0);
    
%%% Plot sphere around each 'g' (terminal) tip to represent a cluster (cloud) of
%%% needles
    [xx,yy,zz] = sphere(10);
    xx = 0.13*xx;
    yy = 0.13*yy;
    zz = 0.13*zz;
    
    INdex = KG(CountGtip);
    for jt = 1: length(CountGtip)
        index = INdex(jt);
        surf(xx+ newBR(index,5), yy + newBR(index,6),zz + newBR(index,7), 'EdgeColor', 'r', 'FaceColor', 'r');
    end


%%% Plot sphere around each 'g' (terminal) tip to represent a cluster that are not illuminated by the sonar beam

    KG(CountGtip) = [];
    color = [83/255, 132/255, 10/255];
    for kh = 1: length(KG)
        surf(xx + newBR(KG(kh),5), yy + newBR(KG(kh),6), zz + newBR(KG(kh),7), 'EdgeColor', color, 'FaceColor', color);
    end

    view([140,20])
    
    xlabel('x (m)');
    ylabel('y (m)');
    zlabel('z (m)');
    
    xlim([-5, 15]);
    ylim([-10, 10]);
    zlim([0,13]);
%%%Plot impulse response
axes('Position',[0.2, .7, .2, .2]);
t = (0:24E3-1)/400E3*1E3;
plot(t,imp/max(imp));
xlim([0,60])
ylim([-1,1])
xlabel('time (ms)');
ylabel('amplitude (norm.)');
set(gca, 'YTick',-1:2:1, 'YTickLabel',{'-1';' 1'});
y(j,:) = imp;

end
% name = sprintf('scan_nReps%d_from%d_to_%d.mat', nReps, abs(V_alpha(1)), abs(V_alpha(end)));
% save(name, 'y','lfinBeam','bwidth','V_alpha', 'sonar_loc', 'boxcenter');
% movie2avi(M,sprintf('scan_nReps%d.avi',nReps),'fps',1,'Compression','None');


                