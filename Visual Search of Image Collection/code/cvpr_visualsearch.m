%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_visualsearch.m
%% Skeleton code provided as part of the coursework assessment
%%
%% This code will load in all descriptors pre-computed (by the
%% function cvpr_computedescriptors) from the images in the MSRCv2 dataset.
%%
%% It will pick a descriptor at random and compare all other descriptors to
%% it - by calling cvpr_compare.  In doing so it will rank the images by
%% similarity to the randomly picked descriptor.  Note that initially the
%% function cvpr_compare returns a random number - you need to code it
%% so that it returns the Euclidean distance or some other distance metric
%% between the two descriptors it is passed.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;
%% Uses the extracted image descriptors to run a visual search.

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = '/MATLAB Drive/CW/msrc_objcategimagedatabase_v2/MSRC_ObjCategImageDatabase_v2';

%% Folder that holds the results...
DESCRIPTOR_FOLDER = '/MATLAB Drive/CW/descriptors';
%% and within that folder, another folder to hold the descriptors
%% we are interested in working with
DESCRIPTOR_SUBFOLDER='globalRGBhisto';


%% 1) Load all the descriptors into "ALLFEAT"
%% each row of ALLFEAT is a descriptor (is an image)
classesOfImages = []; %% Need to compute the number of classes in our dataset
ALLFEAT=[];
ALLFILES=cell(1,0);
ctr=1;
allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);

    img=double(imread(imgfname_full));

    thesefeat=[];
    featfile=[DESCRIPTOR_FOLDER,'/',DESCRIPTOR_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    load(featfile,'F');

    ALLFILES{ctr}=imgfname_full;
    ALLFEAT=[ALLFEAT ; F];
    
    % Check the second character of the filename whether it is a digit or a
    % dash and then assign the respective number/ Image Label (scalar) to the 'class' matrix   
    if fname(2) == '_'
        label = str2double(fname(1)); % 1 digit
    else 
        label = str2double(fname(1:2));
    end
    classesOfImages = [classesOfImages ; label]; % Append label scalar to the classes matrix.
    %splitName = split(fname, '-'); %Use underscore as a delimeter
    %classesOfImages(filenum) = str2double(splitName(1));
    ctr=ctr+1;
end

%CATEGORIESh = histogram(classesOfImages).Values;
%CATNum = length(CATEGORIESh);
%disp(CATNum);

%% 2) Pick an image at random & LOAD ITS DESCRIPTOR to be the query
NIMG=size(ALLFEAT,1);           % number of images in collection
queryimg=floor(rand()*NIMG);    % index of a random image

%% CHANGE random
%% Add a nested for loop for class indices


%% 3) Compute the distance between the descriptor of the query image & the descriptor of each image
dst=[];
for i=1:NIMG
    candidate=ALLFEAT(i,:);
    query=ALLFEAT(queryimg,:);
    thedst=cvpr_compare(query,candidate); % Compare the query descriptor AGAINST to each of the 591 image descriptors.
    dst=[dst ; [thedst i]];                % *The query image with a descriptor that matches the query perfectly,
                                           %  ex, distance zero 
end
% The smaller the distance, the more similar the image is to the query.
dst=sortrows(dst,1);  % sort the results


%% CHANGE This to specifc IMAGE
classImgToQuery = floor(301); %selfies

% put all in a loop

% Compute and plot the PRECISION-RECALL Curve for the top 10 results.
precisionRecallCurve_constructor(NIMG, dst, classImgToQuery, allfiles, classesOfImages);

% call PR Curve with EUCLIDEAN distance and OTHER DESCRIPTORS




% L7 part 1 slides 8-20
% Spatial Grid = Colour Grid + Texture Grid
% Try diff levels of *ANGULAR QUANTIZATION*
% Colour Grid -> *Mahalanobis distance*
% .
% .
% EOH = Edge Orientation Histogram -> compute for each grid cell
% Concatenate cells into an image descriptor similarly with *COLOUR APPROACH*
% EOH using Euclidean distance

% https://www.youtube.com/watch?v=nsyf-S6iZLM
% https://www.youtube.com/watch?v=6tKPgIH_Uuc






%% 4) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)



%SHOW=15; % Show top 15 results
%dst=dst(1:SHOW,:);
%outdisplay=[];
%for i=1:size(dst,1)
%   img=imread(ALLFILES{dst(i,2)});
%   img=img(1:2:end,1:2:end,:); % make image a quarter size
%   img=img(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
%   outdisplay=[outdisplay img];
%end
%imshow(outdisplay);
%imagesc(outdisplay);
%axis off;


%% Project image descriptors into *lower dimensional space*
% .                     PCA over dataset
% Write code for eigen model using Eigen_build function for PCA application
%% Mahalanobis distance
%
% LABS cvpr code



% L1 Norm = Manhattan distance
% Cosine Similarity



% distance measures/descriptors





%% Bag of Visual Words retrieval (BoVM)
%% Haris Corner Detector (sparse feature detector)
% plus a SIFT descriptor
% Use K-means to create the codebook
% Compare performance



