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

textureFeatures = [];

firstElementOfSizeArray = 1;
secondElementOfSizeArray = 2;

targetImgSize = size(targetImg);
targetImgR = targetImgSize(firstElementOfSizeArray);
targetImgC = targetImgSize(secondElementOfSizeArray);

for r=1:griDivision
    for c=1:griDivision
         startingRowPosition = round((r-1)*targetImgR / griDivision+1);
        endingRowPosition = round(r*targetImgR / griDivision);

        % check for columns
    end
end



% The image must be grayscaled



bins=0;
threshold=0;

% Reduce the length of the final feature vector using PCA or LDA if needed.





return;
%end