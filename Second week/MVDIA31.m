% Load the Lena image
lena = imread('lena.png');

% Display the original image
figure;
subplot(1, 2, 1);
imshow(lena);
title('Original Lena Image');

% Add noise to the Lena image (for demonstration purposes)
noisy_lena = imnoise(lena, 'salt & pepper', 0.02); % You can adjust the noise level

% Display the noisy image
subplot(1, 2, 2);
imshow(noisy_lena);
title('Noisy Lena Image');

% Convert the noisy image to grayscale
Image_noise_gray = rgb2gray(noisy_lena);

% Apply a median filter to remove noise
filtered_image = medfilt2(Image_noise_gray, [3, 3]); % Adjust the filter size as needed

% Display the filtered image
figure;
subplot(1, 2, 1);
imshow(Image_noise_gray);
title('Gray Noisy Lena Image');

subplot(1, 2, 2);
imshow(filtered_image);
title('Filtered Lena Image');
