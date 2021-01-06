clear
clc

% Set sample frequency
fs = 1000; % Hz

% Load R peaks from a given signal
load('peaks.mat')


R_peaks = Peaks{1,1}.PeakDetection.Rwaves;