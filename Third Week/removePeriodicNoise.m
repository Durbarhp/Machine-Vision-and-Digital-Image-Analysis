% Specify the path to the image
image_path = 'Fig3_Lena_fn.png';

% Set the center frequency and bandwidth
center_frequency = [/* specify the row center */, /* specify the column center */];
bandwidth = /* specify the bandwidth */;

% Call the removePeriodicNoise function
denoised_image = removePeriodicNoise(image_path, center_frequency, bandwidth);

% Function to remove periodic noise using a notch filter
function denoised_image = removePeriodicNoise(image_path, center_frequency, bandwidth)
    % Read the input image
    original_image = imread(image_path);

    % Convert the image to double for processing
    original_image = double(original_image);

    % Compute the Fourier transform of the image
    fft_image = fft2(original_image);

    % Create a notch filter to remove the periodic noise
    [rows, cols] = size(original_image);
    notch_filter = 1 - designnotchfilter(rows, cols, center_frequency, bandwidth);

    % Apply the notch filter to the Fourier transform
    fft_image_denoised = fft_image .* notch_filter;

    % Compute the inverse Fourier transform to get the denoised image
    denoised_image = real(ifft2(fft_image_denoised));

    % Display the original and denoised images
    figure;
    subplot(1, 2, 1), imshow(uint8(original_image), []), title('Original Image');
    subplot(1, 2, 2), imshow(uint8(denoised_image), []), title('Denoised Image');

    % Return the denoised image
    denoised_image = uint8(denoised_image);
end

% Function to design a notch filter
function notch_filter = designnotchfilter(rows, cols, center_frequency, bandwidth)
    [X, Y] = meshgrid(1:cols, 1:rows);
    distances = sqrt((X - center_frequency(2)).^2 + (Y - center_frequency(1)).^2);
    notch_filter = 1 ./ (1 + (distances / bandwidth).^2);
end
