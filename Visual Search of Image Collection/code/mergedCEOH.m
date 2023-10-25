function CEOHdescriptor = mergedCEOH(targetImage, cell, quantizationLevels, cutOffValue)
% pass input arguments given in "copmutedescriptors"
% Same with grid texture constructor but compute mean colour channels of each grid cell -> *MERGE*

xSobel = [1 2 1; 0 0 0; -1 -2 -1];
ySobel = xSobel';

% Determine the rows and columns.     
CEOHdescriptor = [];
grayScaledImage = rgb2gray(targetImage);
[grayImgRow, grayImgCol, ~] = size(grayScaledImage);

blur = [];
textureFeatures = [];

% Normalise Sobel filters for both dimensions.


for r=1:cell
    for c=1:cell
        startingRowPosition = round((r-1)*grayImgRow/cell); % to not be multiplied by zero
        if startingRowPosition == 0
            startingRowPosition = 1;
        end
         endingRowPosition = round(r*grayImgRow/cell);


        startingColPosition = round((c-1)*grayImgCol / cell); % (cell+1) without if ?
        if startingColPosition  == 0
            startingColPosition = 1;
        end
        endingColPosition = round((c*grayImgCol/cell));
        
        grayScaledImgCell = grayScaledImage(startingRowPosition:endingRowPosition, startingColPosition:endingColPosition, :);
        % Now compute mean color channels of current gray image cell
        


    end
end




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