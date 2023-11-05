% Perform PCA on features
% Number of significant components
function [projectedDataInSubSpaceDim EigenPCA_Model] = PerformEigenPCA(observationsFEAT, deflationMeth, varianceThreshold)
    
    EigenPCA_Model = buildEigenModelFromObservations(observationsFEAT);
    EigenPCA_Model = PCA_DeflateEigenmodel(EigenPCA_Model, deflationMeth, varianceThreshold);
    projectedDataInSubSpaceDim = PCA_ProjectDataOntoEigenModel(observationsFEAT, EigenPCA_Model);

end