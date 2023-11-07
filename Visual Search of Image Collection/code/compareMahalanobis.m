 %% Input:
    % FeatureVect1, FeatureVect2 - Vectors for which the Mahalanobis distance is to be calculated.
    % covariance_Eigenvalues - Eigenvalues of the covariance matrix used for scaling the distance.

function distMahal = compareMahalanobis(FeatureVect1, FeatureVect2, covariance_Eigenvalues)

    % Calculate the element-wise squared difference between F1 and F2.
    squared_diff = (FeatureVect1 - FeatureVect2).^2;

    % Divide each squared difference by the corresponding eigenvalue.
    scaled_diff = squared_diff ./ covariance_Eigenvalues;

    % Sum up the scaled squared differences.
    sum_diff = sum(scaled_diff);

    % Take the square root to obtain the Mahalanobis distance.
    distMahal = sqrt(sum_diff);
end
