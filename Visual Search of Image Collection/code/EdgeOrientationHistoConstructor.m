function EOH = EdgeOrientationHistoConstructor(gradientMagnitudeAtEachPixelofTargetCell, gradientOrientationEdgeAtEachPixelofTargetCell, levelsOfQuantization, textureThreshold)
    
    numBins = 8;
    [imgEdgeOrienRow, imgEdgeOrienCol, ~] = size(gradientOrientationEdgeAtEachPixelofTargetCell);
    updatedBinsOfEachEdgeOrient = []; % values of bins for the edge angle to be stored
        
    

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



    %% Only count orientations from strong edges
    % start the nested for here




end
        % Something like: COLOUR + EOH = result

        %E = [E ComputeEdgeOrientationHistogram(subImage)];
        %C = ComputeGlobalColour(subImage);
        % C(1) = Average Red, C(2) = Average Green, C(3) = Average Blue
        %A = [A C(1) C(2) C(3)];
        %G = [E A];
                                    %% SOS
        % Reduce the length of the final feature vector using PCA or LDA if needed
