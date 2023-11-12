close all;
clear all;


DATASET_FOLDER = '/MATLAB Drive/CW/msrc_objcategimagedatabase_v2/MSRC_ObjCategImageDatabase_v2';


OUT_FOLDER = '/MATLAB Drive/CW/descriptors';

OUT_SUBFOLDER_AVG_RGB = 'avgRGB';
DESCRIPTOR_SUBFOLDER_GLOBAL='globalRGBhisto';
DESCRIPTOR_SUBFOLDER_SPATIAL_COLOUR_GRID = 'SpatialColourGrid';
DESCRIPTOR_SUBFOLDER_SPATIAL_TEXTURE_GRID = 'SpatialGridTexture'; 
DESCRIPTOR_SUBFOLDER_EOH = 'EdgeOrientationHisto';
DESCRIPTOR_SUBFOLDER_MERGE_CEOH = 'ceoh';       % Colour+Edges


allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));

% For quantization 4 works better than 3.
QuantzLevel = 4; %3,4,5,6,7 

grids = 4; %4,6,8,10
spatialAngularLevel = 4;
spatialThreshold = 0.29;

for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255; %% comment for Global RGB.
    
    %fout=[OUT_FOLDER,'/',OUT_SUBFOLDER_AVG_RGB,'/',fname(1:end-4),'.mat'];
    % Extract descriptor from img & returns a random vector
    % F=extractAvgRGB(img); 
    
    %% UNCOMMENT
    % Call Global Colour histogram to be computed      
    %fout=[OUT_FOLDER,'/',DESCRIPTOR_SUBFOLDER_GLOBAL,'/',fname(1:end-4),'.mat'];
    %F = GCH_generator(img, QuantzLevel);

    % Grid Colour histogram
    %fout=[OUT_FOLDER,'/',DESCRIPTOR_SUBFOLDER_SPATIAL_COLOUR_GRID,'/',fname(1:end-4),'.mat'];
    %F = gridColourHistoConstructor(img, grids);
    
    % Spatial Grid Texture
    %fout=[OUT_FOLDER,'/',DESCRIPTOR_SUBFOLDER_SPATIAL_TEXTURE_GRID,'/',fname(1:end-4),'.mat'];
    %F = gridTextureConstructor(img, grids, spatialAngularLevel, spatialThreshold);
    
    % CEOH
    fout=[OUT_FOLDER,'/',DESCRIPTOR_SUBFOLDER_MERGE_CEOH,'/',fname(1:end-4),'.mat'];
    F = mergedCEOH(img, grids, spatialAngularLevel, spatialThreshold);

    save(fout,'F');
    toc
end


%%                   SOS
% https://en.wikipedia.org/wiki/Content-based_image_retrieval

