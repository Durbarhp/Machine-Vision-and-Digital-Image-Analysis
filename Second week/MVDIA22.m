% Read the image
Figure = imread('planet.jpg');

% Convert to grayscale if the image is RGB
if size(Figure, 3) == 3
    Figure = rgb2gray(Figure);
end

% Convert to double for processing
Figure_double = double(Figure);

% Perform contrast stretching
minimum_intensity = min(Figure_double(:));
maximum_intensity = max(Figure_double(:));

% Scale intensities to cover the full dynamic range
stretched_image = uint8((Figure_double - minimum_intensity) / (maximum_intensity - minimum_intensity) * 255);

% Display original and contrast-stretched images
figure;
subplot(1, 2, 1);
imshow(Figure);
title('Original Image');

subplot(1, 2, 2);
imshow(stretched_image);
title('Contrast-Stretched Image in the left');

% Display histograms
figure;
subplot(2, 1, 1);
imhist(Figure);
title('Original Image Histogram');

subplot(2, 1, 2);
imhist(stretched_image);
title('Contrast-Stretched Image Histogram in th left');
