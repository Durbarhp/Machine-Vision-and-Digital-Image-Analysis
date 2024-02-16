% Given 8x8 image
original_image = [4 4 4 4 4 4 4 0;
                  4 5 5 5 5 5 4 0;
                  4 5 6 6 6 5 4 0;
                  4 5 6 7 6 5 4 0;
                  4 5 6 6 6 5 4 0;
                  4 5 5 5 5 5 4 0;
                  4 4 4 4 4 4 4 0;
                  4 4 4 4 4 4 4 0];

% Calculate histogram
count_histogram = hist(original_image(:), 0:7);

% Calculate cumulative distribution function
distribution = cumsum(count_histogram);

% Get the size of the image
[M, N] = size(original_image);

% Apply histogram equalization
equalized_image = zeros(M, N);

for i = 1:M
    for j = 1:N
        equalized_image(i, j) = round((7/(M*N)) * distribution(original_image(i, j) + 1));
    end
end

% Display original and equalized images
figure;
subplot(1, 2, 1);
imshow(original_image, [0, 7]);
title('Original Image');

subplot(1, 2, 2);
imshow(equalized_image, [0, 7]);
title('Equalized Image');
