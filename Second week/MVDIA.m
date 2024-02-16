% Read the image
original_image = imread('planet.jpg');

% Convert to grayscale if the image is RGB
if size(original_image, 3) == 3
    original_image = rgb2gray(original_image);
end

% Convert to uint8 for compatibility
original_image = uint8(original_image);

% Calculate the histogram
histogram_counts = hist(original_image(:), 0:255);

% Calculate cumulative distribution function
cumulative_distribution = cumsum(histogram_counts);

% Normalize cumulative distribution to [0, 255]
cumulative_distribution = (cumulative_distribution / numel(original_image)) * 255;

% Create the equalized image
equalized_image = round(cumulative_distribution(original_image + 1));

% Convert equalized image to uint8 for compatibility
equalized_image = uint8(equalized_image);

% Display original and equalized images
figure;
subplot(1, 3, 1);
imshow(original_image);
title('Original Image');

subplot(1, 3, 2);
imshow(equalized_image);
title('Equalized Image');

% Calculate and display the image difference
image_difference = imabsdiff(original_image, equalized_image);
subplot(1, 3, 3);
imshow(image_difference, []);
title('Image Difference');

% Display histograms
figure;
subplot(2, 1, 1);
imhist(original_image);
title('Original Image Histogram');

subplot(2, 1, 2);
imhist(equalized_image);
title('Equalized Image Histogram');
