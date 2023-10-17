function [precision, recall] = precisionRecallCurve_constructor(numImgs, distSimilarities, classImgQuery, ImgsCollection)

% Get the name of the image to query within the class it belongs to.
classImgIndex=ImgsCollection(classImgQuery).name;

groundTruthVector = zeros([1, numImgs-1]); % Assuming all images are initially irrelevant

% Convert img index name to character array


% Top 5 are relevant images in the ground truth
relevantImages = distSimilarities(1:5, 2); % Need to adjust based on the ACTUAL RELEVANCE criteria
groundTruthVector(relevantImages)=1;

% Initialise arrays to store precision and recall values
precision = zeros([1, numImgs-1]); % 1D array initialised with zeros
recall = zeros([1, numImgs-1]); 

% Compute precision and recall at each threshold
for i = 1:numImgs
    retrievedImages = distSimilarities(1:i, 2); % Gives error IndexOutOfBounds -> DELETE

    % Calculate the true positives (Relevant Images Retrieved)
    truePositives = sum(groundTruthVector(retrievedImages));
    % Precision  at i retrieved images
    precision(i) = truePositives / i;
    % Recall at i retrieved images
    recall(i) = truePositives / sum(groundTruthVector);
end

numEachImgCategory = 30;
% queryFeature


% Plot the PR Curve
figure(3);
plot(recall, precision, 'LineWidth', 2);
hold on;
xlabel('Recall');
ylabel('Precision');
title('Precision-Recall Curve');
xlim([0 1]); % Limit values to range from 0 to 1
ylim([0 1]);
%legend('house', 'car', 'tree')
% figure

% [X,Y] = perfcurve(labels,scores,posclass);


% https://www.youtube.com/watch?v=k-qgz1N5l7Y

%return;
end