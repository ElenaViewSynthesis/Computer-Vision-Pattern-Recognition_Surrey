%% Computes the Mahalanobis distance of data points from an Eigenmodel, measured in standard deviations.
%
% Mahalanobis distance uses ellipsoid to "scale" Euclidean distance.
%
% INPUT:        EigenM              - Eigen Model to measure distance from observations
%               observationsFEAT    - d is row, n is column matrix of observations
%
% OUTPUT:           distMahal - distance of each observation (1 column of n rows)

function distMahal = compareMahalanobisDist_Eigen(observationsFEAT, EigenM)
    % Center the feature points by subtracting the mean from each
    % observation, making the data points centered around origin.
    centered_FEAT_observations = observationsFEAT - repmat(EigenM.MeanPerDimension, 1, size(observationsFEAT, 2));
    
    % Project the centered data/features onto the Eigenmodel's basis, obtaining the 
    % coordinates of the data points in the Eigenmodel's Space (defined by E.eigenvectors).
    dataProjectedInEigenModelSpace = EigenM.vct' * centered_FEAT_observations;   % projections
    
    % Calculate the squared distances of each feature point in the Eigenmodel's space.
    squaredDistancesInEigenSpace = dataProjectedInEigenModelSpace .* dataProjectedInEigenModelSpace;

    % Any eigenvalues with a value of 0 must be replaced with 1 to prevent division by zero.
    EigenM.val(EigenM.val==0) = 1;

    % Mahalanobis distance for each data point in the eigenmodel space, which have been 
    % scaled by the eigenvalues. Divide squared distances by the eigenvalues.
    % Scale the distances along each dimension by the variance explained by the eigenvalues.
    scaledDistancesOnEigenvalues = squaredDistancesInEigenSpace ./ repmat((EigenM.val), 1, size(observationsFEAT, 2));
    
    % Sum Mahalanobis distances for each data point, resulting in a single distance value for the entire image.
    distMahal = sum(scaledDistancesOnEigenvalues);                  % total
    
    % final step
    distMahal = sqrt(distMahal);


%return;
end

                                            %% NOTES:
 % The Mahalanobis distance is a measure of the distance between a data point and the center of the 
 % distribution, taking into account the covariance structure of the data.
 % 
 % Center of the Distribution: is a point that represents the center of the data distribution. 
 % The point around which the data tends to cluster or group.
 %
 % Taking Covariance into Account: When calculating the Mahalanobis distance, we consider not just 
 % how far Point A is from the Center but also how the data is spread or "varied" in different
 % directions. This takes into account the shape of the data distribution.
 %
 % Covariance Structure: The "covariance structure" refers to how different dimensions or features 
 % in the data relate to each other. It considers whether changes in one dimension (like height) 
 % are related to changes in another (like weight).


