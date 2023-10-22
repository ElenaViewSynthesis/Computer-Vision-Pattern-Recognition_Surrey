function precisionRecallCurve_constructor(numImgs, distSimilarities, classImgQuery, ImgsCollection, ImgCategories)

% Get the name of the image to query within the class it belongs to.
classImgIndex=ImgsCollection(classImgQuery).name;

groundTruthVector = zeros([1, numImgs-1]);


% Convert img index name to character array-matrix in order to access individual
% characters using indexing.
classImgIndexChar = char(classImgIndex);
% Extract the first two chars from the char matrix to determine the class of query image
retrievedImgClass = classImgIndexChar(1:2);
% (1:2) captures the category information, which is typically encoded in the first two characters of the file name.
%disp(retrievedImgClass); % TO REMOVE

% OBSERVE the Images foler in the dataset => approx 30 images for each category
numEachImgCategory = 30;
numCategories = 20;
totalElements = 0; %% Last Image class_20 does not contain 30 bmp elements like the other classes

relevantCategories = hist(ImgCategories,numCategories); % histogram with 20 bins
quantityOfCateg = size(relevantCategories,2);
CONFUSION = zeros(quantityOfCateg);
categoryPos = [301;352;382;412;442;472;502;532;562;1;33;63;97;127;157;181;211;241;271;331];
%categoryPos = [1;33;63;97;127;157;181;211;241;271;301;331;352;382;412;442;472;502;532;562];


% Count total image elements within the interest image class
%for b=1:length(ImgsCollection)
%    classes = char(ImgsCollection(b).name);
%    if classes(1:2) == retrievedImgClass
%        totalElements = totalElements +1; % += operator not recognised in MATLAB
%    end
%end

% Top 5 are relevant images in the ground truth
%relevantImages = distSimilarities(1:5, 2);
%groundTruthVector(relevantImages)=1;

% Initialise arrays to store precision and recall values

precision = zeros([1, numImgs-1]); % 1D array
recall = zeros([1, numImgs-1]); 

AVGPRECISION = [];
for labelPos=1:quantityOfCateg

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
    target = categoryPos(labelPos);
    
truePositives = 0;
auxPvalue = 0;

p = [];
r = []; 


% If not working => Histogram of each Image Class

% CHECK for two digits fileame with extra IF
%for k=1:size(distSimilarities,1)
%    imgRankedName = char(ImgsCollection(distSimilarities(k,2)).name);
%    imgRankedClass = imgRankedName(1:2);
%    if imgRankedClass == retrievedImgClass
%        truePositives = truePositives + 1;
%    end

% Find row of the feature category and extract all images.
    for k=1:size(distSimilarities,1)
        imgRankedCategory = ImgCategories(distSimilarities(k,2),:);
        if imgRankedCategory == labelPos
            truePositives = truePositives +1;
        end

        precisionValues = truePositives / k;
        recallValues = truePositives / relevantCategories(labelPos);
        
        % Append the new value to the recall array r as a new row.
        r = [r ; recallValues]; 
        p = [p ; precisionValues];
        if imgRankedCategory == labelPos
            auxPvalue = auxPvalue + precisionValues;
        end
    end
    

% Average Precision (AP) for each class
% in a loop for every single class 
    avgP = auxPvalue/relevantCategories(labelPos);
    AVGPRECISION = [AVGPRECISION; avgP];
 
% Calculate the confusion chart
    distSimilarities = distSimilarities(1:15,:);

    for n=1:size(distSimilarities,1)
        imgRankedCategory = ImgCategories(distSimilarities(n,2),:);
        if imgRankedCategory == labelPos
            CONFUSION(labelPos, labelPos) = CONFUSION(labelPos, labelPos) + 1;
        else 
            CONFUSION(labelPos, imgRankedCategory) = CONFUSION(labelPos, imgRankedCategory) + 1;
        end
    end
end

% Compute MAP over all queries for Average Precision 
%avgP = p .* 
% ap = trapz(r,p);
disp("Average Precision");
disp(AVGPRECISION);

% Mean Average Precision (MAP)
% .
% The MAP provides a single summary value for the overall performance of the descriptors. 
% The confusion matrix visualizes the ranking performance across classes.
MeanAveragePrecision = sum(AVGPRECISION) / quantityOfCateg;
disp("MEAN AP");
disp(MeanAveragePrecision);



% conffig - Display a confusion matrix 
% confmat - Compute a confusion matrix
% .
% ConfusionMatrix = confusionmat(trueValue, predictedValue);
% .
% TransConfusionMatrix = ConfusionMatrix'
% diagonal = diag(TransConfusionMatrix);
% then we need the sum of each row (each image of allfeat[] in every row)



figure(5);
% Create the chart for confusion matrix (NEED to embed MAP)
confusionchart(CONFUSION);

% [X,Y] = perfcurve(labels,scores,posclass);

%figure;
% Plot the PR Curve
%plot(r, p, 'LineWidth', 2, 'Marker','o');
%xlabel('Recall');
%ylabel('Precision');
%title('Precision Recall Curve');
%xlim([0 1]); % Limit values to range from 0 to 1
%ylim([0 1]);
%legend('house', 'car', 'tree') % REMOVeeeeee

% https://www.youtube.com/watch?v=k-qgz1N5l7Y

                                    % Improvements:
           %% Use interpolated precision to smooth the PR curve rather than raw precision value.
           %% Plot the full PR curve in addition to the confusion matrix.
           %% Compare AP and MAP for different descriptors/parameters to quantify improvements.
           %% Use MAP as the optimization metric when training classifiers or tuning parameters.

           




return;