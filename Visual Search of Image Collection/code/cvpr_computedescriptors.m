%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_computedescriptors.m
%% Skeleton code provided as part of the coursework assessment
%% This code will iterate through every image in the MSRCv2 dataset
%% and call a function 'extractRandom' to extract a descriptor from the
%% image.  Currently that function returns just a random vector so should
%% be changed as part of the coursework exercise.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = '/MATLAB Drive/CW/msrc_objcategimagedatabase_v2/MSRC_ObjCategImageDatabase_v2';

%% Create a folder to hold the results (descriptors extracted by the program)
OUT_FOLDER = '/MATLAB Drive/CW/descriptors';
%% and within that folder, create another folder to hold these descriptors
%% the idea is all your descriptors are in individual folders - within
%% the folder specified as 'OUT_FOLDER'.
%OUT_SUBFOLDER ='globalRGBhisto';
OUT_SUBFOLDER_AVG_RGB = 'avgRGB';


allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
    fout=[OUT_FOLDER,'/',OUT_SUBFOLDER_AVG_RGB,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    F=extractAvgRGB(img);
   
    %F=GCH_generator(img,QuantzLevel);
    save(fout,'F');
    toc
end

% Here 
%QuantzLevel = 8;
%GCH_generator(img,QuantzLevel);





