function GridTexture = gridTextureConstructor(targetImg, griDivision)

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
        

        %% Now, compute the orientation of edges
        %% Estimation of edge orientation theta with atan((df/dy) / (df/dx))
        % theta = 0-360 || 0-2pi
        
        
         %% SOS: Normalise prior to concatenation 
        % Quantise orientation into 8 bins (0-2pi)
                % agnle = orientation

         % sobel_imgOR = mod(atan2(img_y, img_x), 2*pi);
         angle_img = angle_img - min(reshape(angle_img, 1, [])); % convert img matrix to 1D row vector.
        

        %% Only count orientations from strong edges

        % EOH (frequency) histogram depicts the frequency of pixels that for every value of theta of
        % pixel inside the cell belongs to one of the bins 
        
        
        % Avoid noisy regions by checking if theta is greater than threshold
       
        

        % Something like that
        %E = [E ComputeEdgeOrientationHistogram(subImage)];
        %C = ComputeGlobalColour(subImage);
        % C(1) = Average Red, C(2) = Average Green, C(3) = Average Blue
        %A = [A C(1) C(2) C(3)];
        

    end
end

%G = [E A];


% For Texture Features experiment with different levels of angular
% quantization


bins=0;
threshold=0;

% Reduce the length of the final feature vector using PCA or LDA if needed.





return;
%end


                                %% OBESRVATIONS:
% Apply some smoothing to the gradient orientation image before quantizing angles. A small Gaussian blur will reduce noise.
% Use adaptive binning instead of fixed bins. This allows higher resolution in busy regions vs uniform regions.
% Weight pixels based on gradient magnitude when building histogram. Gives more importance to stronger edges.
% Normalize histogram to sum to 1 to account for different edge densities.
% Use a circular histogram instead of linear to properly capture angles.
% Extract edges in other color channels or color spaces, not just grayscale.
% Concatenate multiple oriented histograms with different angular resolution.
% 
%% Using more robust edge detection, adaptive quantization, weighting, normalization, 
%% and multi-scale histograms could improve the representation of edge texture for the region.


