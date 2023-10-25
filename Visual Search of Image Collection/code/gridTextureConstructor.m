function GridTextureDescr = gridTextureConstructor(targetImg, griDivision, levelsOfQuantization, textureThreshold)

    %% Law's Texture Energy Convolution masks:
    %% L5-Level mask: detects horizontal texture
    %% E5-Edge mask: detects horizontal edges
    %% S5-Spot mask: detects sparse foreground textures
    %% R5-Ripple mask: detects *sinusoidal variations*
    % Similarly, for vertical variations (L5,E5,S5,R5)
% convolve the image with small convolution kernels that capture different types of texture patterns.

L5 = [-1 2 -1];
E5 = [-1 0 1];
S5 = [1 2 1];
R5 = [1 -2 1];

SpatialGridTextureDescr = [];
%% Bins/Quantization level determine how the range of texture values is divided into discrete intervals, 
% and each bin represents a specific range of texture values.

blur = [];
textureFeatures = [];

firstElementOfSizeArray = 1;
secondElementOfSizeArray = 2;

targetImgSize = size(targetImg);
targetImgR = targetImgSize(firstElementOfSizeArray);
targetImgC = targetImgSize(secondElementOfSizeArray);

xSobel = [S5 ; 0 0 0; -1 -2 -1]; % for horizontal (edges) differentiation
ySobel = xSobel'; % By taking the transpose, it computes the difference in intensity 
                    % between adjacent pixels along the vertical direction.

% For experimentation purposes
 sobelNorm = 4;
xSobelNormalised = xSobel ./ sobelNorm;
ySobelNormalised = xSobelNormalised';

blurKernel = [1 1 1; 1 1 1; 1 1 1];
normalisator = 9;
normalisedBlurKernel = blurKernel ./ normalisator;

for r=1:griDivision
    for c=1:griDivision
         startingRowPosition = round((r-1)*targetImgR / griDivision+1);
        endingRowPosition = round(r*targetImgR / griDivision);
        startingColPosition = round((c-1)*targetImgC / griDivision+1);
        endingColPosition = round((c*targetImgC/griDivision));

        targetImgCell = targetImg(startingRowPosition:endingRowPosition, startingColPosition:endingColPosition, :);
        
        % The image must be grayscaled
        grayImgCell = double(rgb2gray(targetImgCell));

        %% ASK shall we reduce noise first? 
        % use an average filtering for smoothing the image like blur-conv?
        % set matrix to 1 -> divide by 9 to normalise the kernel so it sums to 1.
        % each element of the kernel contributes equally to the average.
        imgBlur = conv2(grayImgCell, normalisedBlurKernel, 'same') ;
        % 'same' in 'conv2' specifies the output to be the same size as the input.
           
        %% Double check this
        % the structure of the image can be given by edges
        % Edge Detecting filter -> Sobel
        % Run a convolution over the image using differentiation df/dx and df/dy
        xDiffSobel = conv2(imgBlur, xSobelNormalised, 'same');
        yDiffSobel = conv2(imgBlur, ySobelNormalised, 'same');
                                                              
        %% Gradient Magnitude Computation 
        % Get the edgeMagnitude (square them up individually, addition, sqrt of sum)
        gradientMagnitudeAtEachPixelofTargetCell = sqrt((xDiffSobel .^ 2) + (yDiffSobel .^ 2));
    
        %% Now, compute the orientation of edges
        %% Estimation of edge orientation theta with atan((df/dy) / (df/dx))
        % atan2(y, x) calculates the angle theta = arctan(y/x) in radians
        gradientOrientationEdgeAtEachPixelofTargetCell = atan2(yDiffSobel, xDiffSobel);
         % gradientOrientationAngleAtEachPixelofTargetCell = mod(atan2(img_y, img_x), 2*pi);
        
         %% SOS: Normalise prior to concatenation 
        % Quantise orientation into 8 bins (0-2pi), % theta = 0-360 || 0-2pi
         % Map angles to [0, 2pi] instead of [-pi, pi] for easier histogram creation.
        gradientOrientationEdgeAtEachPixelofTargetCell = gradientOrientationEdgeAtEachPixelofTargetCell - min(reshape(gradientOrientationEdgeAtEachPixelofTargetCell, 1, [])); % convert img matrix to 1D row vector.
        
        %% Only count orientations from strong edges        ???

        % EOH (frequency) histogram depicts the frequency of pixels that for every value of theta of
        % pixel inside the cell belongs to one of the bins 
        eoh = EdgeOrientationHistoConstructor(gradientMagnitudeAtEachPixelofTargetCell, gradientOrientationEdgeAtEachPixelofTargetCell, levelsOfQuantization, textureThreshold);
        SpatialGridTextureDescr = [SpatialGridTextureDescr eoh];
              

    end
end
GridTextureDescr = SpatialGridTextureDescr;
return;


                                %% OBESRVATIONS:
% Apply some smoothing to the gradient orientation image before quantizing angles. A small Gaussian blur will reduce noise.
% Use adaptive binning instead of fixed bins. This allows higher resolution in busy regions vs uniform regions.
% Weight pixels based on gradient magnitude when building histogram. Gives more importance to stronger edges.
% Normalize histogram to sum to 1 to account for different edge densities.
% Use a circular histogram instead of linear to properly capture angles.
% Extract edges in other color channels or color spaces, not just grayscale.
% Concatenate multiple oriented histograms with different angular resolution.
% 
% Using more robust edge detection, adaptive quantization, weighting, normalization, 
% and multi-scale histograms could improve the representation of edge texture for the region.
% ......................................................................................................................................

                                %% Types of Texture Descriptors:
% Filter-Based Descriptors: These descriptors use filters, such as Gabor filters or wavelet transforms, 
% to analyze the frequency and orientation components of textures.

% Local Binary Patterns (LBP): LBP is a popular texture descriptor that encodes the local spatial patterns 
% of pixel neighborhoods in an image.

% Haralick Features: These features are derived from GLCM and capture texture properties like contrast, 
% energy, entropy, and correlation.

% Texture Energy Measures: These measures compute texture energy or contrast based on pixel intensity gradients.

% Fractal-Based Descriptors: These descriptors use fractal theory to capture self-similarity or self-affinity in textures.


