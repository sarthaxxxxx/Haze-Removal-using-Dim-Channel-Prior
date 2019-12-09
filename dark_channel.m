function darkchannel = dark_channel(image, window_size)

[m, n, ~] = size(image);

pad_size = floor(window_size/2);

padded_image = padarray(image, [pad_size pad_size], Inf);

darkchannel = zeros(m, n); 

for j = 1 : m
    for i = 1 : n
        patch = padded_image(j : j + (window_size-1), i : i + (window_size-1), :);

        darkchannel(j,i) = min(patch(:));
     end
end

end