% Load data from .m file
load('Dataone.mat');

% Preprocess the data

data = normalize(data);

% Assuming you have labels for your data (replace 'labels' with your actual label variable)
labels = randi([0, 1], size(data, 1), 1);  

% Split the data into training and testing sets
rng(42);  % Set seed for reproducibility
cv = cvpartition(labels, 'HoldOut', 0.2);
idxTrain = training(cv);
XTrain = data(idxTrain, :);
YTrain = labels(idxTrain, :);
XTest = data(~idxTrain, :);
YTest = labels(~idxTrain, :);

% Train a Naive Bayes classifier
nb = fitcnb(XTrain, YTrain);

% Make predictions on the test set
YPred = predict(nb, XTest);

% Evaluate the accuracy
accuracy = sum(YPred == YTest) / numel(YTest);
disp(['Accuracy: ', num2str(accuracy * 100), '%']);
