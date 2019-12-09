function [scene_radiance] = dehaze_attempt( image, omega, window_size, lambda )

if ~exist('omega', 'var')
    omega = 0.95;
end

if ~exist('win_size', 'var')
    window_size = 15;
end

if ~exist('lambda', 'var')
    lambda = 0.0001;
end

[m, n, ~] = size(image);

darkchannel = dark_channel(image, window_size);
figure(2),imshow(darkchannel),title('Dark Channel');

fin_atmosphere = atmosphere(image, darkchannel);
%figure(3),imshow(fin_atmosphere),title('Atmospheric Estimate');

transmission_est = transmission_estimate(image, fin_atmosphere, omega, window_size);
figure(4),imshow(transmission_est),title('Transmission Estimate');

lap = laplacian(image);

A = lap + lambda * speye(size(lap));
B = lambda * transmission_est(:);

x = A \ B;

transmission_final = reshape(x, m, n);

scene_radiance = radiance(image, transmission_final, fin_atmosphere);
figure(5),imshow(scene_radiance),title('Recovered Scene Radiance');

end

