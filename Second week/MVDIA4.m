% Read the Lena image
lena_image = imread('lena.png');

% Convert the image to grayscale if it's in RGB format
if size(lena_image, 3) == 3
    lena_image = rgb2gray(lena_image);
end

% Apply Laplacian kernel for image sharpening
sharpened_lena = imsharpen(lena_image);

% Display the original and sharpened images side by side
figure;
subplot(1, 2, 1), imshow(lena_image), title('Original Lena');
subplot(1, 2, 2), imshow(sharpened_lena), title('Sharpened Lena');

% Save the sharpened image if needed
imwrite(sharpened_lena, 'sharpened_lena.jpg');

