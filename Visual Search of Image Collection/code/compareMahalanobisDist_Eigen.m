% Mahalanobis distance uses ellipsoid to "scale" Euclidean distance.
%

function distMahal = compareMahalanobisDist_Eigen(observationsFEAT, EigenM)
    % Center the feature points by subtracting the mean from each
    % observation, making the data points centered around origin.
    centered_FEAT_observations = observationsFEAT - repmat(EigenM.MeanPerDimension, 1, size(observationsFEAT, 2));
    
    % Project the centered data/features onto the Eigenmodel's basis, obtaining the 
    % coordinates of the data points in the Eigenmodel's Space (defined by E.eigenvectors).
    dataProjectedInEigenModelSpace = EigenM.vct' * centered_FEAT_observations;   % projections
    
    % Calculate the squared distances of each feature point in the Eigenmodel's space.
    squaredDistancesInEigenSpace = dataProjectedInEigenModelSpace .* dataProjectedInEigenModelSpace;


    

%return;
end