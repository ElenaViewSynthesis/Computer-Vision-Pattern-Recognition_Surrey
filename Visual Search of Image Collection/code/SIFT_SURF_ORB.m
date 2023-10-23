%% 1. Preprocess the image collection:
% Extract visual features from each image that capture colour, texture, shape etc.
%% 2. Index the features:
% Use a structure like a K-d tree KDTreeSearcher(features) or inverted
% index to allow fast searching over the feature vectors.
%% 3. Accept a query image:
% Extract features using the same method as for the collection images.
%% 4. Search for similar images:
% Use a distance metric - Euclidean distance to find nearest neighbouts in
% feature space. Rank images by distance.


