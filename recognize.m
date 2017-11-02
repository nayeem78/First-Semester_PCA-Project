function [input_img,output_img,accuracy,L_k,output_img_name,flag1] = recognize(test_img_path,pca_transf_mat,L,D,k)
% A function to recognize test image using pca
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input parameters
%         test_img_path                 path for test image
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
% Output
%         input_img                     this gives the input img selected
%          output_img                       this gives o/p img recognised                                       
%         accuracy                          this gives accuracy
%           L_k                         this gives first 'k' matches
%           output_img_name                 name of output image
%
% Description:
% This function takes the test image and pca transformation matrix , data 
% and label matrix as input and recognises correct face with first 'k' faces
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

error = 0;

% Projection of train images into PCA space whic gives  p*p matrix or p*n_pca matrix
feature_vector = double(D) * pca_transf_mat; 


% Extracting the PCA features from test image
input_img = imread(test_img_path);
test_img_file = dir(test_img_path);



[irow icol] = size(input_img);
in_img = reshape(input_img',1,irow*icol);
in_diff = double(in_img);
%projecting test vector into PCA space
feature_vector_test = in_diff * pca_transf_mat;  %1*N matrix or 1*n_pca matrix

%euclidean distance calculation between test vector and all train vectors
dist = [];
for i = 1 : size(feature_vector,1)
    temp = feature_vector(i,:);
    x_sub = ( norm( feature_vector_test - temp ) )^2;
    dist = [dist x_sub];
end

% sort the distances in ascending order
[d,idx] = sort(dist);

%search for first k vales
%k = 10;

for i = 1:k
    ii = idx(i);
    if strcmp(L(ii,:),test_img_file.name(1:3))  %if label equal
        
        output_img = reshape(D(ii,:),64,64)'; %output the recognised image
        output_img_name = L(ii,:);
        flag1 = '1';
        break;
    else
%         error = error + 1; %if not recognised increase error
        if i == k
            
            output_img = reshape(D(idx(1),:),64,64)';
            output_img_name = L(idx(1),:);
            flag1 = '0';
            
        end
    end
end

L_k = [];
for i = 1:k
    ii = idx(i);
    L_k = [L_k; L(ii,:)];
end

% accuracy = (1-error/57)*100; % calcualte accuracy

%accuracy of algorithm for different first k images as computed from
%recognize_accuracy.m
accuracy = [65.3846   67.3077   69.2308   69.2308   71.1538   71.1538   71.1538   75.0000   80.7692 ...
    80.7692   82.6923   82.6923   84.6154   86.5385   88.4615   92.3077   92.3077   94.2308 ...
    94.2308   94.2308   94.2308   94.2308   94.2308   94.2308   94.2308   94.2308   96.1538 ...
    98.0769   98.0769   98.0769   98.0769   98.0769   98.0769   98.0769  100.0000  100.0000 ...
    100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000 ...
    100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000 ...
    100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000 ...
    100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000 ...
    100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000 ...
    100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000  100.0000 ...
    100.0000  100.0000  100.0000];
    


