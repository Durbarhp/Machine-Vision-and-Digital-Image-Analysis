function applyMedianFilter()
    % Read the input image
    inputImage = imread('Fig2.tif');  

    % Display the original image
    figure;
    subplot(1, 2, 1), imshow(inputImage), title('Original Image');

    % Apply median filter
    filterSize = 7; 
    medianFilteredImage = medianFilter(inputImage, filterSize);

    % Display the filtered image
    subplot(1, 2, 2), imshow(medianFilteredImage), title('Median Filtered Image');
end

function outputImage = medianFilter(inputImage, filterSize)
    % Apply median filter to the input image

    % Convert the input image to double
    inputImage = double(inputImage);

    % Get the size of the input image
    [rows, cols, channels] = size(inputImage);

    % Initialize the output image
    outputImage = zeros(rows, cols, channels);

    % Apply median filter to each color channel
    for channel = 1:channels
        % Iterate through each pixel in the input image
        for i = 1:rows
            for j = 1:cols
                % Get the neighborhood of the current pixel
                neighborhood = inputImage(max(1, i - filterSize):min(rows, i + filterSize), ...
                                          max(1, j - filterSize):min(cols, j + filterSize), channel);

                % Apply median operation to the neighborhood
                outputImage(i, j, channel) = median(neighborhood(:));
            end
        end
    end

    % Convert the output image to uint8
    outputImage = uint8(outputImage);
end
