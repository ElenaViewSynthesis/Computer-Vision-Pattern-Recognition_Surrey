%% Compute distance in standard deviations of FEAT observations from Eigen Model
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
    switch method
        case 'keepn'
            % here
        case 'keepf'
            %here


    end





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

