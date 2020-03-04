function [gauss_sigma ] = predict_gauss_sigma(input_type,input_value)
%PREDICT_GAUSS_SIGMA:Takes as input frequency of incdence & predicts the
%beamwidth for that frequency based on results from horseshoe bats or takes the beamwidth directly and then
%calculates the standard deviation for gauss beampattern
%Input:Beamwidth(-3dB) in degrees or Frequency(kHz): Only between 60-80 kHz
%Output:gauss_sigma:standard deviation for input frequency of incidence or beamwidth
%Created by:Anupam Kumar Gupta, Date: 01/03/2015

if (nargin < 2)
    error('Wrong number of inputs');
end

a = sqrt(2*(-log(0.7079)));
switch input_type
    case 'incident_freq'
        %%% Takes as input incident frequency in 60-80 kHz in kHz, 
        %%% estimates beamwidth(-3dB) from horseshoe bat results and 
        %%% calculates the standard deviation (spread) for gaussian
        %%% beampattern for estimated beamwidth
        
        f = input_value; % frequency b/w 60-80 kHz in kHz
        bmwdth = 0.011333*(f.^3) - 2.3219*(f.^2) + 156.15*f - 3402.7;

        gauss_sigma = 0.5*deg2rad(bmwdth)/a;
    case 'beamwidth'
        %%% Takes as input,beamwidth(-3dB) in degrees & predicts the 
        %%% standard deviation (spread) for gaussian beampattern 
        %%% for input beamwidth
        
        gauss_sigma = 0.5*deg2rad(input_value)/a;
end


end

