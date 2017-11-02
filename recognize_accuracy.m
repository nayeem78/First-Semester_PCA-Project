function recognize_accuracy(test_img_path,pca_transf_mat,L,D)
% A function to plot accuracy vs number of first 'k' images detected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input parameters
%         test_img_path                 path for test images
%                                   
%     
%         pca_transf_mat                this is pca transformation matrix
%                                         which is output from
%                                         featurevector function
%
%          L                            Labels for data matrix, i.e. train
%                                       images , which are names of faces
%          
%            D                            data matrix, which is output from
%                                       createTrainDataBase
%
% Description:
% This function takes the test images and pca transformation matrix , data 
% and label matrix as input and plots accuracy vs first k images detected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Projection of train images into PCA space whic gives  p*p matrix or p*n_pca matrix
feature_vector = double(D) * pca_transf_mat;

testpath_imgs = strcat(test_img_path,'*.jpg');  %path for test images
imagefiles = dir(testpath_imgs);
nfiles = length(imagefiles);   % Number of files found

Dt = [];
%creating test data matrix
for img_idx = 1:nfiles
    %read images
    currentfilename_1 = imagefiles(img_idx).name;
    currentfilename = strcat(test_img_path,currentfilename_1);
    currentimage = imread(currentfilename);
    [irow icol] = size(currentimage);
    
    temp = reshape(currentimage',1,irow*icol);   % Reshaping 2D images into 1D image vectors
    Dt = [Dt; temp];
end

%feature vector of test images
feature_vector_test = double(Dt) * pca_transf_mat;

%euclidean distance calculation between test vectors and all train vectors
for i = 1:size(feature_vector_test,1)
    
    for j = 1 : size(feature_vector,1)
        temp = feature_vector(j,:);
        x_sub = ( norm( feature_vector_test(i,:) - temp ) )^2;
        dist(i,j) = x_sub;
    end
end

% sort the distances in ascending order
[d,idx] = sort(dist,2);


for k = 1:93
    error(k) = 0;
    for i = 1:size(feature_vector_test,1)
        flag1 = 0;
        for j = 1:k
            ii = idx(i,j);
            if strcmp(L(ii,:),imagefiles(i).name(1:3))  %if label equal
                flag1 = 1;
                break;
            end
            
        end
        if flag1 ~= 1
            error(k) = error(k) + 1; %if not recognised increase error
            
        end
    end
    
    accuracy(k) = (1-error(k)/52)*100; % calcualte accuracy
end
accuracy
%to plot accuracy
k = 1:1:93;
plot(k,accuracy)
xlabel('Number of first images (k) used to detect');
ylabel('Accuracy of algorithm');
title('Accuracy vs number of first (k) images');


