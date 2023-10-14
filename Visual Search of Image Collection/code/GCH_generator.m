function H=GCH_generator(img,quantiz_level)
% .
% Create a COLOUR BASED VISUAL SEARCH system using the *Global Colour Histogram
% using Euclidean distance metric.
% *Experiment with different levels of RGB quantization*
% 
% Lecture 7 slide 4-6

%quantiz_level = 4;          % The level of quantization (Q) of the RGB space
% Image where RGB are NORMALISED in range 0 to (quantiz_level - 1)
qimg = double(img) ./256;   % Do this by dividing each pixel value by 256 (so range is 0 - just under 1)
qimg = floor(qimg .*quantiz_level); % Multiply this by Quantization level, then drop/floor the decimal point.

% Create a signle int value for each pixel that SUMARRISES the RGB value.
% Use this as the BIN INDEX in the *histogram*
bin = qimg(:,:,1)*quantiz_level^2 + qimg(:,:,2)*quantiz_level^1 + qimg(:,:,3);

% BIN is a 2D image where each 'pixel' contains an integer value in range 
% [0 - (QuantizationLevel^3)-1] inclusive.

% Build a FREQUENCY HISTOGRAM from these values using the *hist* command.
% Reshape the 2D matrix into a *long vector of values*.

vector_values = reshape(bin,1,size(bin,1)*size(bin,2));
% Create a histogram of Q^3 bins.
H = hist(vector_values,quantiz_level^3);
% Normalise the histogram so the area under it sums to 1.
H = H ./sum(H);

end
%return; %% remove
