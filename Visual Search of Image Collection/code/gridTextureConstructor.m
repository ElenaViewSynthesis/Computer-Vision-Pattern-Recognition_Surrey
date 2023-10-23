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

xSobel = [S5 ; 0 0 0; -1 -2 -1];
ySobel = xSobel';

for r=1:griDivision
    for c=1:griDivision
         startingRowPosition = round((r-1)*targetImgR / griDivision+1);
        endingRowPosition = round(r*targetImgR / griDivision);
        startingColPosition = round((c-1)*targetImgC / griDivision+1);
        endingColPosition = round((c*targetImgC/griDivision));

        targetImgCell = targetImg(startingRowPosition:endingRowPosition, startingColPosition:endingColPosition, :);
        
        % The image must be grayscaled
        grayImgCell = double(rgb2gray(targetImgCell));
           
        % the structure of the image can be given by edges
        % Edge Detecting filter -> Sobel
        % Run a convolution over the image using differentiation df/dx and df/dy
        xDiffSobel = 0;
        yDiffSobel = 0;


        % Get the edgeMagnitude (square them up individually, addition, sqrt of sum)
        

        %% Now, compute the orientation of edges
        %% Estimation of edge orientation theta with atan((df/dy) / (df/dx))
        % theta = 0-360 || 0-2pi
        

        % Quantise orientation into 8 bins (0-2pi)
        

        % EOH (frequency) histogram depicts the frequency of pixels that for every value of theta of
        % pixel inside the cell belongs to one of the bins 
        
        
        % Avoid noisy regions by checking if theta is greater than threshold
        %% Normalise prior to concatenation 
            
         %E = [E ComputeEdgeOrientationHistogram(subImage)];
        %C = ComputeGlobalColour(subImage);
         % C(1) = Average Red, C(2) = Average Green, C(3) = Average Blue
        %A = [A C(1) C(2) C(3)];
        

    end
end

%G = [E A];





bins=0;
threshold=0;

% Reduce the length of the final feature vector using PCA or LDA if needed.





return;
%end