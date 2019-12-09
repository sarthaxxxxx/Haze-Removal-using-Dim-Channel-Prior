clc;
clear all;
close all;

warning('off','all');

tic;
image = double(imread('forest.jpg'))/255;

image = imresize(image,[384,384]);

result = dehaze_attempt(image, 0.95, 15);
toc;

figure(1), imshow(image), title('Input Image')
figure(6), imshow(result), title('De-hazed Image');

warning('on','all');