warning('off','all');
clc;
clear all;
close all;

image = double(imread('ge4.png'));

% image = imresize(image, [512 512]);
figure, imshow(uint8(image),[]),title('Hazy Image')

I_Hdm = HazeDistributionMap(uint8(image));  % Calculate the haze distribution map
HDMHA_I = HazeAssessment(I_Hdm)  % Calculate the assessment result

tic;
result=dehaze_fast(image, 0.95, 5);
toc;
figure, imshow((result),[]),title('Dehazed Image')


J_Hdm = HazeDistributionMap((result));% Calculate the haze distribution map
HDMHA_J = HazeAssessment(J_Hdm)  % Calculate the assessment result

warning('on','all');