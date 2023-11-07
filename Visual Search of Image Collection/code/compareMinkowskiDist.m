%% References: https://en.wikipedia.org/wiki/Euclidean_distance#Squared_Euclidean_distance
%% check GPT \left(\sum_{i=1}^n |x_i-y_i|^p\right)^{1/p}


% Input:
    % FeatureVect1, FeatureVect2 - Vectors or arrays for which the Minkowski distance is to be calculated.
    % p - The order of the Minkowski distance.

function MinkoDis = compareMinkowskiDist(FeatureVect1, FeatureVect2, p)
% A generalization of Euclidean, Manhattan, and Chebyshev distances.
% is controlled by a parameter 'p.' When p=2, it's equivalent to the Euclidean distance, 
% and when p=1, it's equivalent to the Manhattan distance.

    

    % Calculate the absolute differences between corresponding elements of A and B.
    absolute_diff = abs(FeatureVect1 - FeatureVect2);

    % Raise each absolute difference to the power of p.
    powered_diff = absolute_diff.^p;

    % Sum up all the powered differences.
    sum_diff = sum(powered_diff);

    % Take the p-th root of the sum to obtain the Minkowski distance.
    MinkoDis = sum_diff^(1/p);
end





%% Run in visualsearch
% Calculate the Minkowski distance with p=1 (Manhattan distance).
%manhattan_distance = minkowski_distance(A, B, 1);
%disp(manhattan_distance);

% Calculate the Minkowski distance with p=2 (Euclidean distance).
%euclidean_distance = minkowski_distance(A, B, 2);
%disp(euclidean_distance);

% You can also calculate the distance with other values of p.






                                            %% Common Distance Metrics
% Cosine Similarity: This metric measures the cosine of the angle between two non-zero vectors. 
% It's often used in text analysis and image retrieval when you want to measure the orientation rather than the magnitude of vectors.

% Hamming Distance: Primarily used for binary data like binary images or strings, it counts 
% the number of positions at which the corresponding elements of two vectors are different.

% Jaccard Similarity: Commonly used for sets or binary data, it measures the size of the intersection 
% of sets divided by the size of the union of sets. It's useful in applications like image retrieval and document analysis.

% Mahalanobis Distance: This metric takes into account the covariance structure of the data and is useful 
% when the data is not isotropic or when different features have different scales. It's often used in 
% object classification and clustering.

% Chebyshev Distance (L∞ Norm): It's the maximum absolute difference between any coordinate of two points. 
% This is a suitable metric when you want to measure dissimilarity based on the most significant difference between points.

% Correlation Distance: Measures the correlation between two vectors. It's used for finding similarities 
% between patterns when the absolute values are less important than the correlation structure.

% Dynamic Time Warping (DTW): A distance metric used for comparing time series data. It allows for the alignment of similar sequences with variations in time and amplitude.

% Bhattacharyya Distance: Commonly used in image processing and computer vision, it quantifies the statistical 
% similarity between two probability distributions, making it suitable for comparing histograms or pixel values in images.

% Earth Mover's Distance (EMD): Often used in image retrieval and object matching, it calculates the minimum 
% cost required to transform one distribution into another. It's particularly useful for comparing histograms.