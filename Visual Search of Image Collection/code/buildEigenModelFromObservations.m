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
    
    % here
    

% ReduceDimensionalityWithPCA


                        %% REPORT NOTES
% try different quantization and indentify the best approach with average
% precision
% Compare the results
% Evaluate everything
% only need to labe the first class only that we search

% Observation of dataset
% Remove some images from the image categories
% Compare the results with AP & MAP & PR curve

% Ex: histogram worked better for building images but not 
% Pr curve for every class, compare the values

% Descriptor must be invariant of : - instance of the object
%                                   - we dont expect 2 diff images of cows
%                                   to have the same edges.
                                    % similar distribution of colour

% the object of interest
%% INTERPRET Results

% SVM multilabel


%deflate = 10;
    
 %   e_val=e_val(1:deflate);
  %  e_vec=e_vec(:,1:deflate);
    
   % ALLFEAT = ALLFEAT-repmat(size(m_ALLFEAT,1),1);
    %EM = (e_vec'*ALLFEAT')';





end