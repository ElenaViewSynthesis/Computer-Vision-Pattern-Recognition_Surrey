% This functions returns random numbers instead of a real image descriptor.
% Method to compute an image descriptor from an image.
% Compute a 3D Image Descriptor with average RGB values of the image.
% .
% .
% Extract your chosen type of (image) Feature Descriptor.
function F=extractAvgRGB(img)

% F=rand(1,30);

% Returns a row [rand rand .... rand] representing an image descriptor
% computed from image 'img'

% Note img is a normalised RGB image i.e. colours range [0,1] not [0,255].

%% img Prints all the values of feature descriptor
red = img(:,:,1);       % Computing the AVERAGE RED value of the image
red = reshape(red,1,[]);
avg_red = mean(red);

green = img(:,:,2);
green = reshape(green,1,[]);
avg_green = mean(green);

blue = img(:,:,3);
blue = reshape(blue,1,[]);
avg_blue = mean(blue);

% Concatenate these 3 values to form a FEATURE VECTOR F
F = [avg_red avg_green avg_blue];

% returns images with roughly the same overall colour 
% evident in the images with a lot of green grass.
% .
% For now, it just identifies GLOBAL COLOUR in the image.


return;