function EOH = EdgeOrientationHistoConstructor(gradientMagnitudeAtEachPixelofTargetCell, gradientOrientationEdgeAtEachPixelofTargetCell, levelsOfQuantization, textureThreshold)
    
    numBins = 8;
    [imgEdgeOrienRow, imgEdgeOrienCol, ~] = size(gradientOrientationEdgeAtEachPixelofTargetCell);
    updatedBinsOfEachEdgeOrients = []; % values of bins for the edge angle to be stored
        
    

    % ......................................................................................................................................................................
    % Ensure that imgMagnitude and imgOrientation have the same size.
    assert(isequal(size(gradientMagnitudeAtEachPixelofTargetCell), size(gradientOrientationEdgeAtEachPixelofTargetCell)), 'Input images must have the same size.');

    % Initialize the histogram array with zeros.
    %H = zeros(1, bins);

    % Calculate the bin values for all edge orientations.
    valid_indices = gradientMagnitudeAtEachPixelofTargetCell > textureThreshold;
    valid_edges = gradientOrientationEdgeAtEachPixelofTargetCell(valid_indices);

    % Compute the bin values for valid edge orientations.
    bin_values = floor((valid_edges / (2 * pi)) * bins) + 1;

    % Update the histogram.
    %H = histcounts(bin_values, 1:bins + 1);

    % Normalize the histogram to have unit area.
    %H = H / sum(H);
    % ....................................................................................................................................................



    %% Only count orientations from strong edges with comparison to texture threshold
    % start the nested for here 
    for row=1:imgEdgeOrienRow
        for col=1:imgEdgeOrienCol
            if gradientMagnitudeAtEachPixelofTargetCell(imgEdgeOrienRow, imgEdgeOrienCol) > textureThreshold % magnitude threshold
                updatedQuantLevel = ((gradientOrientationEdgeAtEachPixelofTargetCell(imgEdgeOrienRow, imgEdgeOrienCol))/(2*pi));
                updatedQuantLevel = floor(updatedQuantLevel*levelsOfQuantization); % scales the orientation to the range [0, bin). 

                updatedBinsOfEachEdgeOrients = [updatedBinsOfEachEdgeOrients updatedQuantLevel];
            end
        end
    end
    if size(updatedBinsOfEachEdgeOrients, 2) == 0 % matrix along its second dimension/columns is empty.
        EOH = zeros(1, levelsOfQuantization); % a row vector of zeros with a length of bin -> EOH is a valid output even when there are no data points.
    else 
        EOH = histogram(updatedBinsOfEachEdgeOrients, levelsOfQuantization, 'Normalization', 'probability').Values;
    end
return;
%end


