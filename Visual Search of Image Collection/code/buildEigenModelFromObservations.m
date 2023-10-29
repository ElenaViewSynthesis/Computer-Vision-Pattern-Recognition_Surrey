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
function EM = buildEigenModelFromObservations(observationsFEAT)

    Eigen.Num = size(observationsFEAT, 2);
    Eigen.Drow = size(observationsFEAT, 1);
 

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