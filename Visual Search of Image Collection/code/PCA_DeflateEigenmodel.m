%% Compute distance in standard deviations of FEAT observations from Eigen Model
%% how data points deviate from the typical variations captured by the eigenmodel.
%
%% Input:               E       - Eigenmodel to deflate
%%                      method  - Deflation method to use
%%                      param   - Optional parameter based on deflate method
%
%% Output:              E       - Deflated Eigenmodel
%% 
%% Deflation methods:  'keepn' - Keep 'param' of most significant eigenvectors
%%                     'keepf' - Keep 'param' percentage of energy to retain
%%                     
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
function EigenM = PCA_DeflateEigenmodel(E, method, param)
    % The 'param' variable determines the desired percentage of energy.
    switch method
        case 'keepn'                                   
            EigenM.val = EigenM.val(1:param); % Select only the first 'param' eigenvalues, the MOST significant ones.
            EigenM.vct = EigenM.vct(:,1:param); % Select only the first 'param' columns, the MOST significant eigenvectors.
        case 'keepf'
            totalenergy = sum(abs(EigenM.val)); % total energy represents the total variance in the data.
            currentenergy = 0;                  % track how much energy has been accumulated.
            rank = 0;                           % counter of eigenvalues that reach the specified energy threshold.
            
            % Process each eigenvalue One by One and their associated eigenvectors => 
            % Iterate through the eigenvalues in descending order (from the most significant to the least significant).
            for eigenValueIndex = 1:size(EigenM.vct,2)      % Iterate through the number of eigenvectors columns
                if currentenergy > (totalenergy * param)    % Check whether the current accumulated energy exceeds a specified precentage of the total energy.
                    break;                      % If the accumulated energy surpasses the desired threshold, then exit
                end                             % since it reached the desired level of retained energy.
                rank = rank + 1;                % tracker of eigenvalues which have not exceeded the threshold.
                currentenergy = currentenergy + EigenM.val(eigenValueIndex);
                % Current eigenvalue is added to the accumulated energy at each iteration (cumulative energy).
                % Incrementally calculate the energy explained by each eigenvalue, starting with the most significant.
            end
            EigenM = PCA_DeflateEigenmodel(EigenM, 'keepn', rank);
            % Keep only the top 'rank' most significant eigenvectors and their associated 
            % eigenvalues. This reduces the dimensionality of the eigenmodel, as specified by the 'keepn' deflation method.
    end
    % The 'rank' var stores the number of eigenvalues needed to retain the specified percentage of total variance in the data. 
    %% Total energy indicates how much of the total variance in the data is explained by each principal component. 
    %% By monitoring this cumulative energy=> make decisions about how many principal components to retain to capture a certain percentage of the total variance.
    
    %% Larger eigenvalues indicate that the associated eigenvectors capture more 
    %% of the data's variability, while smaller eigenvalues correspond to less significant dimensions or components.
    
    %% Energy or Variance in the Data: In the context of PCA, "energy" or "variance" refers 
    %% to the amount of variability in the dataset. It quantifies how much the data points 
    %% deviate from the mean or central tendency. More variance indicates more spread or dispersion in the data.




                                    %% NOTES:
%% ObservationsFEAT / Data:  Each data point typically has multiple 
%% attributes or features, which can be represented as a vector.
%
%% Eigen Model: The eigenvectors capture the most important directions of variation in
%% the data, while the eigenvalues represent the amount of variance explained 
%% along those directions.
%
%% Distance in Std. Deviations: The "distance" refers to a measure of dissimilarity 
%% or how different one data point is from another. In this context, "distance in standard
%% deviations" is that the function quantifies how many standard deviations 
%% away a data point is from the mean represented by the eigenmodel.

