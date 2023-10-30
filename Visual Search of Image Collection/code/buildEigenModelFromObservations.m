%% Method to build an eigen model from n observations of d-dimensional data.
%% IN: observations     -d row, n column matrix of observations
%%
%% OUT: EM              - Eigenmodel Structure
%%                        - E.org - mean
%%                        - E.vct - matrix of eigenvectors one per column
%%                        - E.val - column of eigenvalues (matching E.vct cols)
%%                        - E.N   - number of observations used, n.
%%                        
%% LICENSE: John Collomosse 2010  (J.Collomosse@surrey.ac.uk)




function EigenM = buildEigenModelFromObservations(observationsFEAT)
% The observations are used to compute the covariance matrix (C) and subsequently find the eigenvectors 
% and eigenvalues of this covariance matrix. The eigenvectors capture the principal components or 
% directions of maximum variance in the data, and the eigenvalues represent the amount 
% of variance explained by each corresponding eigenvector.

    EigenM.Num = size(observationsFEAT, 2); % the dot '.' is used for element-wise operations on structures, is applied to each element of the structure.
    EigenM.Drow = size(observationsFEAT, 1);
    % computes the mean along each row of the FEAT matrix -> represents the mean for each dimension.
    EigenM.MeanPerDimension = mean(observationsFEAT')';

    % subtracting the mean values stored in the  EigenM.MeanPerDimension from each observation in 
    % observationsFEAT => aka centering the data because it shifts the data points such that 
    % the mean of each dimension in the centered data (stored in centered_FEAT_observations) becomes zero.
    % Briefly, it contains the centered/mean-subtracted observations.
    centered_FEAT_observations = observationsFEAT - repmat(EigenM.MeanPerDimension,1,EigenM.Num); 
    
    % Matrix to capture the covariance relationships between the different dimensions of the data & 
    % Identify the directions of maximum variance.
    % It quantifies how the different dimensions of your data arecorrelated with each other.
    % finding the Principal Components (eigenvectors) and their corresponding variances (eigenvalues). 
    DIMENSIONAL_COVARIANCE_MATRIX = (1/EigenM.Num) * (centered_FEAT_observations * centered_FEAT_observations');
    
    % Each column of U represents an eigenvector.
    % The eigenvalues are stored as the diagonal elements of a matrix, and V represents that matrix.
    % The eigenvectors represent the principal components, which are the directions of maximum 
    % variance in the data. The corresponding eigenvalues indicate 
    % the amount of variance explained by each principal component.
    [U V] = eig(DIMENSIONAL_COVARIANCE_MATRIX);
    
    % Sort Eigenvectors & Eigenvalues by eigenvalue (desc)
    % for computing the percentage of variance explained by each eigenvalue, as it 
    % represents the total variance in the data.
    linearColumnVector = V * ones(size(V,2),1); % contains the sum of eigenvectors of V.
    S = [linearColumnVector U']; % The transposition (U') is necessary to ensure that the eigenvectors are stored as columns.
    S = flipud(sortrows(S,1)); % flips the order of the rows in the sorted matrix obtained in the previous step, effectively reversing the order from ascending to descending.
    
    % U contains the eigenvectors corresponding to the eigenvalues in descending order.
    U = S(:,2:end)'; % selects all columns of the S starting from 2nd col to the last => each column of the submatrix becomes a row in U.
    V = S(:,1); % Isolate the sorted eigenvalues (in descending order) from S.
    % eigenvalues represent the amount of variance explained by each corresponding principal component (eigenvector). 
    
    EigenM.vct = U; % Store the sorted eigenvectors of U to the eigenmodel structure field.
    EigenM.val = V; % Assign the sorted eigenvalues.



                                    %% Extra Notes for REVISION
    % Eigenvalues (D): eig() returns a diagonal matrix (D) containing the eigenvalues of the input matrix. 
    % The eigenvalues represent the scaling factors by which the eigenvectors are stretched or shrunk.
    % Each eigenvalue corresponds to a specific eigenvector.

    % Eigenvectors (V): The eig() function also returns a matrix (V) where each column represents an 
    % eigenvector corresponding to the eigenvalues in matrix D. These eigenvectors are often normalized
    % to have a magnitude of 1. 

    % In PCA, the eigenvalues and eigenvectors of the covariance matrix represent the principal components 
    % of the data. The eigenvectors define new coordinate axes (principal components) in the data space,
    % while the eigenvalues indicate the amount of variance along each principal component. By sorting 
    % the eigenvalues in descending order, you can identify the most significant principal components, 
    % which can be used for dimensionality reduction and feature extraction.
end