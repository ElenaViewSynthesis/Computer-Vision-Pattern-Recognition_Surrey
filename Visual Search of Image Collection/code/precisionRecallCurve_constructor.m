function [precision, recall] = precisionRecallCurve_constructor(numImgs, distSimilarities, classImgQuery, ImgsCollection)

% Get the name of the image to query within the class it belongs to.
classImgIndex=ImgsCollection(classImgQuery).name;

groundTruthVector = zeros([1, numImgs-1]);

% Convert img index name to character array-matrix in order to access individual
% characters using indexing.
classImgIndexChar = char(classImgIndex);
% Extract the first two chars from the char matrix to determine the class of query image
retrievedImgClass = classImgIndexChar(1:2);
% (1:2) captures the category information, which is typically encoded in the first two characters of the file name.
disp(retrievedImgClass); % TO REMOVE

numEachImgCategory = 30;
totalElements = 0; %% Last Image class_20 does not contain 30 bmp elements like the other classes

% Count total image elements within the interest image class
for b=1:length(ImgsCollection)
    classes = char(ImgsCollection(b).name);
    if classes(1:2) == retrievedImgClass
        totalElements = totalElements +1; % += operator not recognised in MATLAB
    end
end

% Top 5 are relevant images in the ground truth
%relevantImages = distSimilarities(1:5, 2);
%groundTruthVector(relevantImages)=1;

% Initialise arrays to store precision and recall values
truePositives = 0;
precision = zeros([1, numImgs-1]); % 1D array
recall = zeros([1, numImgs-1]); 

% Compute precision and recall at each threshold
%for i = 1:numImgs
 %   retrievedImages = distSimilarities(1:i, 2); 
    % Calculate the true positives (Relevant Images Retrieved)
  %  truePositives = sum(groundTruthVector(retrievedImages));
    % Precision  at i retrieved images
   % precision(i) = truePositives / i;
    % Recall at i retrieved images
    %recall(i) = truePositives / sum(groundTruthVector);
%end

for k=1:size(distSimilarities,1)
    imgRankedName = char(ImgsCollection(distSimilarities(k,2)).name);
    imgRankedClass = imgRankedName(1:2);
    if imgRankedClass == retrievedImgClass
        truePositives = truePositives + 1;
    end
    
end


% queryFeature




% If not working => Histogram of each Image Class (histoImgClass)



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