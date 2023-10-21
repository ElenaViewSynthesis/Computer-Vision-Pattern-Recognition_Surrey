function ColourGrid = gridColourHistoConstructor(targetImg, griDivision)
% Method to represent the colour information within each "Grid Cell".
    % 1) Divide the image into a grid of cells (numRows & numCols in the grid
         % determines the size and shape of the cells. Num of grids: gxg

    % 2) Compute a colour histogram for each grid cell (representing the distribution of colours within the cell).
    % 3) Concatenate Histograms: To create the final descriptor for the entire
         % image => combine all colour histograms obtained from each grid cell.
    % 4) Normalization: of the histogram values to ensure they are comparable across different images.
         % L1 normalization (sum of histogram bins equals 1) or L2 - Euclidean normalization. 


 % rem() remainder, horzcat() 'horizontal concatenation' along columns.
firstElementOfSizeArray = 1;
secondElementOfSizeArray = 2;

targetImgSize = size(targetImg);
targetImgR = targetImgSize(firstElementOfSizeArray);
targetImgC = targetImgSize(secondElementOfSizeArray);


% imhist function
SPATIAL_COLOUR_GRID = [];

% 
for r=1:griDivision
    for c=1:griDivision
        % Determine the row n col boundaries of the grid cell
        % Ensure that the image is divided into grid cells *EVENLY*
        % +1 ensures that the starting row of the cell is included
        startingRowPosition = round((r-1)*targetImgR / griDivision+1); % must use an int value for index => round
            %Edge case: r-1= 0*0 = 0      if()
        endingRowPosition = round(r*targetImgR / griDivision);

        startingColPosition = round((c-1)*targetImgC / griDivision+1);
        endingColPosition = round((c*targetImgC/griDivision));

        % Extract the pixel data from the image which falls within the current cell.
        % Capture the color information within the cell.
        % a specific cell within the grid
        targetImgCell = targetImg(startingRowPosition:endingRowPosition, startingColPosition:endingColPosition, :);
        

        % ?? Call Global Colour Descriptor to create the histogram
        % Concatenate them to form an image descriptor
        RGB_Averages = extractAvgRGB(targetImgCell); % 3-element array representing RGB
        SPATIAL_COLOUR_GRID = [SPATIAL_COLOUR_GRID RGB_Averages(1) RGB_Averages(2) RGB_Averages(3)];
    end
end
ColourGrid = SPATIAL_COLOUR_GRID;
%histogram = (ColourGrid);

return;
%end