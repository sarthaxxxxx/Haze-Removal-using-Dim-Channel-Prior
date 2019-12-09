%% demo
%
% This demo illustrates the dehazing method for single remote sensing image
%introduced in the paper
%
% Xiaoxi Pan, Fengying Xie, Zhiguo Jiang and Jihao Yin, "Haze Removal for a
% Single Remote Sensing Image Based on Deformed Haze Imaging Model", 
% IEEE Signal Processing Letters, vol.22, no.10, pp.1806-1810, 2015.
%
% Notes:
%   To get the optimal performance, the parameter C
%   should be optimized for each kind of remote sensimg images.
%
%
% Date: May, 2016
% ------------------------------------------------------------------------

%%
clc;
clear all;
close all;
filename = strcat('\testimages\images5.jpg');

I = imread(filename);
figure, imshow(I), title('Hazy Image');
C = 27;   % default value for Google Earth images; 
% C is derived from a kind of statistics of haze-free remote sensing images 
% and is used to reduce the deviation when using the dark channel prior to 
% estimate the transmission.
J = hazeremoval(I, C);
figure, imshow(J), title('De-Hazed Image');
I_Hdm = HazeDistributionMap(I);  % Calculate the haze distribution map
HDMHA_I = HazeAssessment(I_Hdm)  % Calculate the assessment result
J_Hdm = HazeDistributionMap(J);  % Calculate the haze distribution map
HDMHA_J = HazeAssessment(J_Hdm)   % Calculate the assessment result