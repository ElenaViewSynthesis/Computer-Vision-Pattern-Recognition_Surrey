%% Project data onto eigenmodel basis
%% 
%% INPUT:               E   - Eigenmodel to project points
%%                      obs - Data (points) to project
%%
%% OUTPUT:              pobs - Projected data
%
%% (c) John Collomosse 2010
function  projectedObs = PCA_ProjectDataOntoEigenModel(observationsFEAT, EigenM)
    
    % Centers the data/observation points by subtracting the mean of the data - FeaturesCenteredAtOrigin. 
    meanCenteredFEATobservations = observationsFEAT - repmat(EigenM.MeanPerDimension, 1, size(observationsFEAT,2));
    projectedObs = EigenM.vct' * meanCenteredFEATobservations; % perform the actual projection of the translated/centered data 
                                                               % onto the eigenmodel basis by multiplying the transpose of the 
                                                               % eigenvectors matrix (EigenM.vct) with the centred feature points.
                                                               % It projects the data points onto the principal components represented 
                                                               % by the eigenvectors, effectively reducing the dimensionality of the data.

%% Each column of 'projectedObs' corresponds to a projected feature/data point in this reuced-dimensional space. 
% The translated data will be used for PCA & the principal components (eigenvectors) obtained from this
% data represent the directions of *Maximum Variance* around the origin.


% Elbow Graph to plot

end

                                        %% NOTES:
  % "Translated data" in the context of PCA refers to the data points which have been adjusted or
  % shifted in such a way that their mean(or center) aligns with the origin(0,0,0 in a multi-dimensional space).
  %% Why Translate Data? It simplifies the analysis  because it *aligns the principal axes of
  %% variation with the coordinate axes* (translating the data to have its mean at the origin - removing the center of mass) 
  %% => easier to identify the *most important directions of variability in the data*.

