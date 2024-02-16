Fig3 = imread('Fig3_Lena_fn.png');
image = im2double(Fig3);
[m, n] = size(image);

% Taking FFT of the Noisy Image
fft_noisy_image = fft2(Fig3);
fft_shifted_noisy_image = fftshift(fft_noisy_image);
magnitude_spectrum_noisy_image = log(1 + abs(fft_shifted_noisy_image));
normalized_magnitude_spectrum = magnitude_spectrum_noisy_image / max(magnitude_spectrum_noisy_image(:));

figure;
imshow(im2uint8(normalized_magnitude_spectrum));
title("Frequency Spectrum of Noisy Lena Image");

% Read the image
input_image = Fig3;

% Compute FFT
fft_image = fft2(input_image);
fft_shifted_image = fftshift(fft_image);
phase_spectrum = angle(fft_shifted_image);
magnitude_spectrum_image = 20 * log(abs(fft_shifted_image));

% Image shape
image_shape = size(input_image);

% Define notch reject filters
notch_filter1 = notch_reject_filter(image_shape, 10, 29, 130);
notch_filter2 = notch_reject_filter(image_shape, 10, -29, 130);
notch_filter3 = notch_reject_filter(image_shape, 10, -29, 0);
notch_filter4 = notch_reject_filter(image_shape, 10, 0, -130);
notch_filter5 = notch_reject_filter(image_shape, 10, -130, -130);

% Apply notch reject filters
composite_notch_filter = notch_filter1 .* notch_filter2 .* notch_filter3 .* notch_filter4 .* notch_filter5;
filtered_spectrum = magnitude_spectrum_image .* composite_notch_filter;
filtered_image_fft_shifted = fft_shifted_image .* composite_notch_filter;
inverse_filtered_image_fft_shifted = ifftshift(filtered_image_fft_shifted);
inverse_filtered_image = ifft2(inverse_filtered_image_fft_shifted);

%Figure
figure;
imshow(abs(inverse_filtered_image), []);
title('Periodic Noise removed');

% Plotting
figure;
subplot(2, 2, 1);
imshow(input_image, []);
title('Original Image');

subplot(2, 2, 2);
imshow(magnitude_spectrum_image, []);
title('Magnitude Spectrum of Original Image');

subplot(2, 2, 3);
imshow(filtered_spectrum, []);
title('Filtered Magnitude Spectrum');

subplot(2, 2, 4);
imshow(abs(inverse_filtered_image), []);
title('Denoised Image');



colormap gray;

function notch_filter = notch_reject_filter(shape, d0, u_k, v_k)
    Shape1 = shape(1);
    Shape2 = shape(2);
    
    % Initialize filter with zeros
    notch_filter = zeros(Shape1, Shape2);

    % Traverse through filter
    for n = 1:Shape1
        for v = 1:Shape2
            % Get euclidean distance from point D(u,v) to the center
            D_uv = sqrt((n - Shape1 / 2 + u_k)^2 + (v - Shape2 / 2 + v_k)^2);
            D_muv = sqrt((n - Shape1 / 2 - u_k)^2 + (v - Shape2 / 2 - v_k)^2);

            if D_uv <= d0 || D_muv <= d0
                notch_filter(n, v) = 0.0;
            else
                notch_filter(n, v) = 1.0;
            end
        end
    end
end
