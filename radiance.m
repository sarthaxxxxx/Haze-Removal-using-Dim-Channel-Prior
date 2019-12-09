function scene_radiance = radiance(image, transmission_est, fin_atmosphere)

[m, n, ~] = size(image);

rep_atmosphere = repmat(reshape(fin_atmosphere, [1, 1, 3]), m, n);

max_transmission = repmat(max(transmission_est, 0.1), [1, 1, 3]);

scene_radiance = ((image - (rep_atmosphere)) ./ double(max_transmission)) + rep_atmosphere;

end