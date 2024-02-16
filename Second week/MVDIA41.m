% Read the Lena image
image = imread('lena.png');

% Convert the image to grayscale if it's in RGB format
if size(image, 3) == 3
    image = rgb2gray(image);
end

% Apply Gaussian smoothing
lena_smooth = imgaussfilt(image, 2);  % Adjust the standard deviation as needed

% Display the original and smoothed images side by side
figure;
subplot(1, 2, 1), imshow(image), title('Original Lena');
subplot(1, 2, 2), imshow(lena_smooth), title('Smoothed Lena');

% Save the smoothed image if needed
imwrite(lena_smooth, 'smoothed_lena.jpg');
