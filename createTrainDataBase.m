function [D,L] = createTrainDataBase(trainpath)
% A function to create database for train images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input parameters
%         trainpath                   path for train images
%
% Output
%         D                           Data matrix of all train images (p x d)
%                                     p - number of images (here 93)
%                                     d - number of variables (here 4096 pxs)
%
%         L                           Labels to data matrix (names of persons)
%
% Description:
% This function takes the path of train images and create a data matrix of all
% train images and label the images with person's name of first three characters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


trainpath_imgs = strcat(trainpath,'*.jpg');  %path for train images
imagefiles = dir(trainpath_imgs);
nfiles = length(imagefiles);   % Number of files found

D = []; %data matrix
L = []; %label matrix

for img_idx = 1:nfiles
    %read images
    currentfilename_1 = imagefiles(img_idx).name;
    currentfilename = strcat(trainpath,currentfilename_1);
    currentimage = imread(currentfilename);
    [irow icol] = size(currentimage);
    
    temp = reshape(currentimage',1,irow*icol);   % Reshaping 2D images into 1D image vectors
    D = [D; temp];
    L = [L; currentfilename_1(1:3)];
    
end