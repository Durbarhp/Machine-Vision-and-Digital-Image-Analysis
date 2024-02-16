% Read Lena image
lena1_image = imread('Fig1_lena_n.png');

% Convert to double for numerical calculations
lena1_image = im2double(lena1_image);

% Display the original image
figure;
subplot(1, 3, 1);
imshow(lena1_image);
title('Original Image');

% Simulate Gaussian Noise
mu = 0;          
sigma = 0.02;    

gaussian_noise = sigma * randn(size(lena1_image));
lena_with_gaussian_noise = lena1_image + gaussian_noise;

% Display image with Gaussian noise
subplot(1, 3, 2);
imshow(lena_with_gaussian_noise);
title('Image with Gaussian Noise');

% Simulate Uniform Noise
a = -0.02;   % Minimum value for uniform noise
b = 0.02;    % Maximum value for uniform noise

uniform_noise = (b - a) * rand(size(lena1_image)) + a;
lena_with_uniform_noise = lena1_image + uniform_noise;

% Display image with Uniform noise
subplot(1, 3, 3);
imshow(lena_with_uniform_noise);
title('Image Uniform Noise');
