function GridTexture = gridTextureConstructor(targetImg, griDivision)

    %% Law's Texture Energy Convolution masks:
    %% L5-Level mask: detects horizontal texture
    %% E5-Edge mask: detects horizontal edges
    %% S5-Spot mask: detects sparse foreground textures
    %% R5-Ripple mask: detects *sinusoidal variations*
    % Similarly, for vertical variations (L5,E5,S5,R5)
% convolve the image with small convolution kernels that capture different types of texture patterns.






% Reduce the length of the final feature vector using PCA or LDA if needed.





return;
%end