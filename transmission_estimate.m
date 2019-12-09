function transmission_est = transmission_estimate(image, fin_atmosphere, omega, window_size)

[m, n, ~] = size(image);

repeat_atmosphere = repmat(reshape(fin_atmosphere, [1, 1, 3]), m, n);

transmission_est = 1 - omega * dark_channel( image ./ repeat_atmosphere, window_size);

end