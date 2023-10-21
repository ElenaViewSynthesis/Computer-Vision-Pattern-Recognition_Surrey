close all;
clear all;

DATASET_FOLDER ='/MATLAB Drive/CW/msrc_objcategimagedatabase_v2/MSRC_ObjCategImageDatabase_v2';
OUT_FOLDER = '/MATLAB Drive/CW/descriptors';
OUT_SUBFOLDER_SPATIAL_COLOUR_GRID = 'colourGrid';


gridSize = 4;

allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
    
    fout=[OUT_FOLDER,'/',OUT_SUBFOLDER_SPATIAL_COLOUR_GRID,'/',fname(1:end-4),'.mat'];
    
    GRIDCOLOUR = gridColourHistoConstructor(img, gridSize);
    

    
    save(fout,'GRIDCOLOUR');
    toc
end


% IMPLEMENT another descriptor for Texture features histo   ?

