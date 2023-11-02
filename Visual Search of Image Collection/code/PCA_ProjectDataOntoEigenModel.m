%% References: https://en.wikipedia.org/wiki/Euclidean_distance#Squared_Euclidean_distance

%% Project data onto eigenmodel basis
%% 
%% INPUT:               E   - Eigenmodel to project points
%%                      obs - Data (points) to project
%%
%% OUTPUT:              pobs - Projected data
%
%% (c) John Collomosse 2010
function  pobs = PCA_ProjectDataOntoEigenModel(observationsFEAT, E)
    meanCenteredFEATobservations = observationsFEAT; % WORK here
    
    

% The translated data will be used for PCA & the principal components (eigenvectors) obtained from this
% data represent the directions of *Maximum Variance* around the origin.


% Elbow Graph


end

                                        %% NOTES:
  % "Translated data" in the context of PCA refers to the data points which have been adjusted or
  % shifted in such a way that their mean(or center) aligns with the origin(0,0,0 in a multi-dimensional space).
  %% Why Translate Data? It simplifies the analysis  because it *aligns the principal axes of
  %% variation with the coordinate axes* (translating the data to have its mean at the origin - removing the center of mass) 
  %% => easier to identify the *most important directions of variability in the data*.

