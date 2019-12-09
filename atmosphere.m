function fin_atmosphere = atmosphere(image, darkchannel)

[m, n, ~] = size(image);
n_pixels = m * n;

n_search_pixels = floor(n_pixels * 0.01);

dark_vec = reshape(darkchannel, n_pixels, 1);

image_vec = reshape(image, n_pixels, 3);

[~, indices] = sort(dark_vec, 'descend');

accu = zeros(1, 3);

for k = 1 : n_search_pixels
    accu = accu + image_vec(indices(k),:);
end

fin_atmosphere = accu / n_search_pixels;

end