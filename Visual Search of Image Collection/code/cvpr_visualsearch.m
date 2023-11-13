close all;
clear all;

DATASET_FOLDER = '/MATLAB Drive/CW/msrc_objcategimagedatabase_v2/MSRC_ObjCategImageDatabase_v2';
DESCRIPTOR_FOLDER = '/MATLAB Drive/CW/descriptors';

%% UNCOMMENT for each descriptor
%SUBFOLDER = 'globalRGBhisto';
%SUBFOLDER = 'SpatialColourGrid';       %Run with respective to computed DESC
%SUBFOLDER = 'SpatialGridTexture'; 
%SUBFOLDER = 'EdgeOrientationHisto';
SUBFOLDER = 'ceoh';
%SUBFOLDER = 'BagsOfWords';


% Step 1
classesOfImages = []; % Need to compute the number of classes in the dataset
categories = {"farm", "tree", "building", "aeroplane", "cow", "selfie", "car", "bike", "sheep", "flower", "sign", "bird", "book", "bench", "cat", "dog", "road", "water", "people", "coast"};
ImageCategories = [];
ALLFEAT=[];
ALLFILES=cell(1,0);
ctr=1;
allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    
    %% Extract the numerical category identifier from the start of the filename for precision-recall analysis.
    % Use regular expression to extract the category number from the filename.
    % Assuming the category number is always at the beginning followed by an underscore.
    categoryMatch = regexp(fname, '^\d+', 'match');
    if ~isempty(categoryMatch)
        ImageCategories(filenum) = str2double(categoryMatch{1});
    else
        ImageCategories(filenum) = NaN; % Assign NaN for filenames that do not match the expected pattern.
    end


    img=double(imread(imgfname_full))./255;

    thesefeat=[];
    featfile=[DESCRIPTOR_FOLDER,'/',SUBFOLDER,'/',fname(1:end-4),'.mat'];
    % load every descr to allfeatmatrix
    load(featfile,'F');
    % Every row within ALLFEAT serves as a descriptor, representing an individual image.
    ALLFILES{ctr} = imgfname_full;
    ALLFEAT=[ALLFEAT ; F];
    
    % Check the second character of the filename whether it is a digit or a
    % dash and then assign the respective number/ Image Label (scalar) to the 'class' matrix   
    if fname(2) == '_'
        label = str2double(fname(1)); % 1 digit
    else 
        label = str2double(fname(1:2));
    end
    classesOfImages = [classesOfImages ; label]; % Append label scalar to the classes matrix.
    ctr=ctr+1;
end

%% UNCOMMENT
IndexToSearch = [300 350 380 436 440 470 510 537 570 4 62 80 100 128 180 218 268 277 333];

CATEGORIEShisto = histogram(classesOfImages).Values;
categNum = length(CATEGORIEShisto);
disp(categNum); % display number of all categories (20) of images in a separate bin with each its total num of images.


%% Project image descriptors into *lower dimensional space*
%                      PCA over dataset
% Write code for eigen model using Eigen_build function for PCA application
%% Mahalanobis distance
% Compute Eigen Model -> Project Data to Eigenmodel Basis

RUN_PCA_on_ALLFEAT=[];
applyPCA = true; %to perform PCA
energyToRetain = 0.85;
if applyPCA                                     %% Lecture 7, slide 12
    inputFeatureDescriptorsPCA = ALLFEAT;      % switching rows and columns, r represent samples, and col - features (dimensions).
    
    [reducedFeatureDescriptorsAfterPCA, EigenModel] = PerformEigenPCA(inputFeatureDescriptorsPCA, 'keepf', energyToRetain);
    % Transpose back to its original format, with rows representing samples and columns representing features.
    % Update with reduced dimensions. 
    RUN_PCA_on_ALLFEAT = reducedFeatureDescriptorsAfterPCA;  
    E = EigenModel;
    %fprintf('REDUCED DIMENSIONS: ', size(reducedFeatureDescriptorsAfterPCA));
    %clear inputFeatureDescriptorsPCA reducedFeatureDescriptorsAfterPCA;
end

                    % FIX

%% 2) Pick an image at random & LOAD ITS DESCRIPTOR to be the query
NIMG=size(ALLFEAT,1);                           % number of images in collection
queryimg=537;    % rand()*NIMG           % index of a random image
% floor(537);
% floor(421);

%% CHANGE random
%% Add a nested for loop for class indices



% Lecture Slides (not for use)
%eigenB = eigenBuild(ALLFEAT');
%eigenDef = EigenDeflate(eigenB, "keepn",3);
%ALLFEATONPCA = EigenProject(ALLFEAT', eigenDef)';

%% UNCOMMENT
%plot3(reducedFeatureDescriptorsAfterPCA(:,1), reducedFeatureDescriptorsAfterPCA(:,2), reducedFeatureDescriptorsAfterPCA(:,3), 'bx');
%xlabel('EigenVector1');
%ylabel('EigenVector2');
%zlabel('EigenVector3');


%% Run Image Queries here
 




% L1 Norm = Manhattan distance
% Cosine Similarity
%% 3) Compute the distance between the descriptor of the query image & the descriptor of each image
dst=[];
r=[];
p=[];

for i=1:NIMG
    candidate = ALLFEAT(i,:);        
    query = ALLFEAT(queryimg,:);
    
    % Compare with mahalanobis on all features
    if applyPCA
        thedst = compareMahalanobis(query, candidate, E.val); %TRANSPOSE E.val inside Mahal function. 
    else
        %% UNCOMMENT
        % thedst = compareL1Norm_Manhattan(query, candidate); 

    % Calculate a 3rd-order Minkowski distance (p=3) aka cubic distance metric. 
    % Measures the dissimilarity between vectors with a higher sensitivity to extreme differences.
        
        %% UNCOMMENT
        % thedst = compareMinkowskiDist(query, candidate, 3);

        thedst=cvpr_compare(query, candidate); % Compare the query descriptor AGAINST to each of the 591 image descriptors with *EUCLIDEAN*.
                                           % *The query image with a
                                           % descriptor that matches the
                                           % query perfectly, then distance zero.
    end
    %% FIX
    dst=[dst ; [thedst i]]; % ; [thedst i allfiles(i).class allfiles(i).imgNum]];               
                                           
end
% The smaller the distance, the more similar the image is to the query.
dst=sortrows(dst,1);


%% CHANGE This to specific IMAGE
%classImgToQuery = floor(301); %selfie
classImgToQuery = 537;



% put all in a loop ....


% Compute PRECISION-RECALL Curve for the top 10 results.
precisionRecallCurve_constructor(NIMG, dst, classImgToQuery, allfiles, classesOfImages);

% call PR Curve with EUCLIDEAN distance and OTHER DESCRIPTORS




% L7 part 1 slides 8-20 
%% *Spatial Grid* = Colour Grid + Texture Grid
% Try diff levels of *ANGULAR QUANTIZATION* for texture features
% 
% Accumulate the MAGNITUDE of colour+texture within each angle bin to create a histogram
%% Colour Grid -> *Mahalanobis distance*
% .
% .
%% EOH = Edge Orientation Histogram -> (TEXTURE info) compute for each grid cell
% Concatenate cells into an image descriptor similarly with *COLOUR APPROACH*
%% EOH using Euclidean distance
%%           with Sobel filter -> estimate edge orientation theta

%% *COMBINE* EOH & COLOUR








%% 4) Visualise the results

DISPLAY=15;
dst=dst(1:DISPLAY,:);
outdisplay=[];
for i=1:size(dst,1)
   img=imread(ALLFILES{dst(i,2)});
   img=img(1:2:end,1:2:end,:); 
   img=img(1:81,:,:); 
   outdisplay=[outdisplay img];
end
%imshow(outdisplay);
% imagesc(outdisplay);  % not use

figure, imshow(outdisplay);
axis off;



% distance measures/descriptors
% .
% . 
%               Wavelet Transform based Preprocessing & Features Extraction
% 
%               https://www.youtube.com/watch?v=YF0zq9bcaAE





%% Bag of Visual Words retrieval (BoVM)
%% Haris Corner Detector (sparse feature detector)
% plus a SIFT descriptor
% Use K-means to create the codebook
% Compare performance



%% New: "Image indexing using color correlograms"
%% NEW: Canny Edge Detector 
%  The output edges will be a binary edge map instead of gradient values.
%  compute orientation from the edge pixels.
%  Generate the histogram from Orientation and Magnitude as before.
%  Tune the Canny thresholds to get good edge maps for your images.

                        %% Canny vs Sobel:
         % Use Canny instead of Sobel to getcleaner edges.
         % Canny does additional processing like non-max suppression to get
         % better edges.
         % Compute gradient orientation and magnitude from the Canny edge map.
         % Build weighted histogram using magnitude for importance.
         %%  MATLAB built-in Canny edge detector 









% For Video MPEG-7 Visual Shape Descriptors
%% https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=927426
% 1) Shape Spectrum - 3D Shape Descriptor
% 2) Angular Radial Transformation (ART) - Region-Based Shape Descriptor
% 3) Contour-Based Shape Descriptor
% 4) 2D/3D Descriptor



%% References:
% https://www.vlfeat.org/overview/tut.html

                            %% Notes Taking
% Feature Descriptors: These are representations of distinct features in an 
% image that are useful for tasks like object recognition, matching, and tracking.

% Histogram Descriptors: These are based on histograms of pixel intensities, colors, or other attributes within an image.

% Shape Descriptors: These describe the shape or contour of objects within an image, 
% often including properties like area, perimeter, and eccentricity.

% Color Descriptors: These represent color information within an image, typically using color histograms or color moments.

% Texture Descriptors: As mentioned earlier, these capture textural properties and patterns within an image.

% Local Feature Descriptors: These represent local regions of an image, often used in object recognition and 
% matching. Examples include SIFT (Scale-Invariant Feature Transform) and SURF (Speeded-Up Robust Features).

% Edge Descriptors: These focus on the detection and representation of edges within an image.

% Corner Descriptors: These are focused on detecting and representing corner points within an image, 
% often used in image alignment and registration.

% Scale-Invariant Descriptors: These are descriptors that remain consistent even when an image is scaled (i.e., SIFT features).

% Rotation-Invariant Descriptors: These are descriptors that remain consistent under rotation (i.e., ORB features).

% Texture-Based Descriptors: These descriptors focus on capturing and distinguishing different textures in images.

% Appearance Descriptors: These describe the overall appearance or visual characteristics of objects or scenes.

% Local Binary Descriptors: These are binary representations of local image patches, often used in real-time applications.

% Shape Context Descriptors: These describe the spatial distribution of edge or contour points relative to a reference point.

% Statistical Descriptors: These include moments, variances, and statistical measures that describe the image's 
% pixel intensity distribution.

% Invariance Descriptors: These aim to capture invariance properties, such as rotation, translation, and scale invariance.

% Haar-like Descriptors: Used in object detection and face detection, these descriptors are based on Haar-like features.

% HOG (Histogram of Oriented Gradients) Descriptors: Used for object detection and pedestrian detection, 
% HOG captures gradient information in local image regions.

% Haralick Texture Descriptors: These quantify texture features based on gray-level co-occurrence matrices.

% Fractal Descriptors: These capture self-similarity or fractal properties in textures and images.

%% Elkan k-means for fast visual word dictionary construction.

                                        %% LOCAL DESCRIPTORS
% They capture the local visual information around interest points or keypoints in an image. 
% This allows matching and comparison of local regions between images.

% Popular local descriptor algorithms include SIFT, SURF, ORB, BRISK, FREAK, etc. SIFT and SURF are considered
% more robust but slower, while ORB, BRISK and FREAK trade off some robustness for faster computation.

% They are used for tasks like image matching, object recognition, image stitching, 3D reconstruction, SLAM, etc. 
% Matching local descriptors between images allows finding correspondences between them.

% Advances like bag of visual words (BoVW), descriptor quantization, and descriptor matching with geospatial 
% verification have improved the scalability and accuracy of local descriptor techniques.

% CNN-based descriptors like LIFT are also gaining popularity, offering more discrimination but higher 
% computation than traditional descriptors.
% ..............................................................................................................................
%% Dense SIFT (DSIFT) & PHOW: Extracting dense SIFT features for image classification.

%% Local Intensity Order Pattern (LIOP)(alternative to SIFT in keypoint matching): 

%% Covariant Feature Detectors
% (multiscale corner) Harris-Laplace    | (blob)  Hessian-Laplace & Hessian-Hessian | detectors

%% Maximally Stable Extremal Regions (MSER): Extracting MSERs from an image as an alternative covariant feature detector.

%% Image distance transform: Compute the image distance transform for fast part models and edge matching.

%% Fisher vector and VLAD encodings: Compute global image encodings by pooling local image features with Fisher vectors and VLAD.

% ..............................................................................................................................

%% Gaussian Mixture Models (GMM) with Expectation Maximization (EM algorithm)

%% Simple Linear Iterative Clustering (SLIC) algorithm for superpixel generation
%% image distance transform: PEGASOS, floating point K-means, homogeneous kernel maps.
%% Detection Error Trade-off (DET) curves.


% Trivial notes:
% "Estimation of Feature Orientation" refers to the process of determining the dominant orientation of a local image feature.
% Local Feature Region: The process begins with the selection of a local region around the feature point of interest. This region can be a small patch or a neighborhood of pixels.

% Gradient Computation: Within this local region, the next step is to compute the gradient information. 
% The gradient is calculated to determine how the pixel values change in both the x and y directions. 
% The gradient magnitude represents the strength of the changes, while the gradient angle indicates 
% the direction of the changes. Common methods for gradient computation include using Sobel operators or 
% other convolution filters.

% Accumulating Gradient Histogram: Once the gradients are computed, a histogram is created to accumulate 
% the gradient orientations. Each pixel's gradient angle contributes to a particular bin in the histogram.

% Dominant Orientation: The bin with the highest count (peak) in the histogram is considered the dominant 
% orientation of the feature. This dominant orientation represents the overall direction in which 
% the intensity changes are most prominent within the local region.

% Orientation Assignment: The dominant orientation is assigned to the feature point, which makes the 
% feature description rotation-invariant. This means that even if the local feature patch is rotated, 
% the assigned orientation ensures that the feature description is consistent.

% Orientation Histogram: In some cases, multiple dominant orientations might be assigned if there are 
% multiple peaks in the gradient histogram. This can be useful in situations where a feature is not 
% strongly oriented in a single direction.

%%  By assigning a dominant orientation to a feature, these SIFT, SURF algorithms ensure that 
%% the feature's representation is invariant to rotations.

%% Support Vector Machine (SVM): Binary classifier and check its convergence by plotting various statistical info.

% Agglomerative Information Bottleneck (AIB): Cluster discrete data based on the mutual 
% information between the data and class labels.

%% Forests of kd-trees: Approximate nearest neighbour queries in high dimensions using an optimized forest of kd-trees.





