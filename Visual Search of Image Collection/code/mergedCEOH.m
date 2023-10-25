function CEOHdescriptor = mergedCEOH(targetImage, cell, quantizationLevels, cutOffValue)
% pass input arguments given in "copmutedescriptors"
% Same with grid texture constructor but compute mean colour channels of each grid cell -> *MERGE*

xSobel = [1 2 1; 0 0 0; -1 -2 -1];
ySobel = xSobel';

% Normalise Sobel filters for both dimensions

% Determine the rows and columns
targetImgSize = size(targetImage);

CEOHdescriptor = [];






        %% Pseudocode: COLOUR + EOH 
        % ..........................................................................................
        % CEOH = [CEOH EdgeOrientationHisto(targetImgCell)];
        % COLORCELL = GCH(targetImgCell);
        % COLORCELL(1) = AvgR     COLORCELL(2) = AvgG       COLORCELL(3) = AvgB
        % AVERAGECOLORCELLS = [AVERAGECORCELLS COLORCELL(1) COLORCELL(2) COLORCELL(3)];
        % mixDescriptor = [CEOH AVERAGECOLORCELLS];
        % ..........................................................................................
                                   
        
        
                                        %% SOS
        % Reduce the length of the final feature vector using PCA or LDA if needed
        %%                        => build Eigen Model

end