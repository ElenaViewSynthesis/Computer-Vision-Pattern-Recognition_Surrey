
close all;
clear all;

DATASET_FOLDER = '/MATLAB Drive/CW/msrc_objcategimagedatabase_v2/MSRC_ObjCategImageDatabase_v2';
OUT_FOLDER = '/MATLAB Drive/CW/descriptors';
OUT_SUBFOLDER ='globalRGBhisto';


allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
QuantzLevel = 8;
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);

    % Image where RGB are NORMALISED in range 0 to (quantiz_level-1) by dividing each pixel value by 256
    img = double(imread(imgfname_full)); %% remove
    fout=[OUT_FOLDER,'/',OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];
   
    F=GCH_generator(img,QuantzLevel);
    save(fout,'F');
    toc
end