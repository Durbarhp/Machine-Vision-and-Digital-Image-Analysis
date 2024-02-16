function motionBlurParameters = estimateMotionBlur(image)
    % Convert gray
    if size(image, 3) == 3
        image = rgb2gray(image);
    end

    % Calculate the gradient in the x and y directions
    [gradientX, gradientY] = gradient(double(image));

    % Calculate the magnitude of the gradient
    gradientMagnitude = sqrt(gradientX.^2 + gradientY.^2);

    % Find the maximum value and its location in the gradient magnitude
    [~, maxIndex] = max(gradientMagnitude(:));
    [row, col] = ind2sub(size(gradientMagnitude), maxIndex);

    % Estimate the length and angle of motion blur
    motionBlurParameters.Length = round(sqrt((row - size(image, 1)/2)^2 + (col - size(image, 2)/2)^2));
    motionBlurParameters.Angle = atan2(row - size(image, 1)/2, col - size(image, 2)/2) * 180/pi;

    disp('Estimated Motion Blur Parameters:');
    disp(['Length: ' num2str(motionBlurParameters.Length)]);
    disp(['Angle: ' num2str(motionBlurParameters.Angle)]);
end
