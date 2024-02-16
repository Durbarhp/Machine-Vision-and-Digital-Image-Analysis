% Read the original image
planet_image = imread('planet.jpg');

% Convert to grayscale if the image is RGB
if size(planet_image, 3) == 3
    planet_image = rgb2gray(planet_image);
end

% Perform histogram equalization
equalized_image = histeq(planet_image);

% Calculate absolute difference
image_difference = imabsdiff(planet_image, equalized_image);

% Display the original image, equalized image, and the difference
figure;

subplot(1, 3, 1);
imshow(planet_image);
title('Original Image');

subplot(1, 3, 2);
imshow(equalized_image);
title('Equalized Image');

subplot(1, 3, 3);
imshow(image_difference);
title('Image Difference after equalization');

% Display histograms
figure;

subplot(2, 1, 1);
imhist(planet_image);
title('Original Image Histogram');

subplot(2, 1, 2);
imhist(equalized_image);
title('Equalized Image Histogram');
