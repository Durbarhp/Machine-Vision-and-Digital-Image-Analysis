% Read the image
planet_image = imread('planet.jpg');

% Convert to grayscale if the image is RGB
if size(planet_image, 3) == 3
    planet_image = rgb2gray(planet_image);
end

% Convert to uint8 for compatibility
planet_image = uint8(planet_image);

% Calculate the histogram
histogram_counts = hist(planet_image(:), 0:255);

% Calculate cumulative distribution function
distribution = cumsum(histogram_counts);

% Normalize cumulative distribution to [0, 255]
distribution = (distribution / numel(planet_image)) * 255;

% Create the equalized image
image_equalized = round(distribution(planet_image + 1));

% Convert equalized image to uint8 for compatibility
image_equalized = uint8(image_equalized);

% Display original and equalized images
figure;
subplot(1, 3, 1);
imshow(planet_image);
title('Original Image');

subplot(1, 3, 2);
imshow(image_equalized);
title('Equalized Image');

% Calculate and display the image difference
image_difference = imabsdiff(planet_image, image_equalized);
subplot(1, 3, 3);
imshow(image_difference, []);
title('Image Difference');

% Display histograms
figure;
subplot(2, 1, 1);
imhist(planet_image);
title('Original Image Histogram');

subplot(2, 1, 2);
imhist(image_equalized);
title('Equalized Image Histogram');
