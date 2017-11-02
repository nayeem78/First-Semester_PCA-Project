function [pca_transf_mat] = featurevector(D,n_pca)


% A function to find featurevectors of train images using PCA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input parameters
%         trainpath                   Data matrix of train images
%                                       (output given by createTrainDataBase function)
%           n_pca                       number of principal components for PCA
%          
%
% Output
%         pca_transf_mat              pca transformation matrix whose
%                                       columns are eigen vectors of D'D/(p-1)
%         
%
% Description:
% This function takes the data matrix and number of principal componenets
% to compute dimension reduction and computes the covriance matrix and
% eigen vectors of covraince matrix. 
%  finally we get PCA transformation matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[m,n] = size(D);

mean_img = mean(D); % mean of all images (1 x d)

mean_matrix = repmat(mean_img,m,1);  %to calculate mean matrix
x_tilda = double(D) - mean_matrix; %remove mean
cx = (x_tilda * x_tilda')./(m-1); %covrainace matrix
[PC,D] = eig(cx); %to claculate eigen vectors

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here we actually need to calculate eigen vectors of D'D which gives d x d matrix
% which is 4096 x 4096. So instead we calculate eigen vectors of DD' 
% which is p x p matrix which is 93 x 93. 
% we require eigen vectors of D'D
% let X be eigen vector of DD' then (DD')X = eX
%                                multiply with D'
%                                (D'D)D'X = e (D'X)
%                                
%                                so here eigen vector of D'D is D'X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                               

D = diag(D);
[c idx] = sort(D,1,'descend');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%for eigen values and cumulative eigen values

%for cumulative eigen values (uncomment below code)
% c_sum = sum(c);
% for k = 1:m
%   c_k(k) = sum(c(1:k,1))/c_sum;
% % to find for what number of eigen value normalised cumulative sum is > 0.95
% %     if c_k(k) > 0.95
% %         disp(k)
% %         break;
% %     end
% end

%xx = 1:1:m; % number of eigen values

% %for plotting eigen values (uncomment below code)
% plot(xx,c);
% xlabel('Number of eigen values');
% ylabel('Eigen values');
% title('Eigen values');

%for plotting cumulative sum (uncomment below code)
% plot(xx,c_k);
% xlabel('Number of eigen values');
% ylabel('cumulative sum of eigen values (normalised)');
% title('Cumulative sum of Eigen values (normalised)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% to put eigen vectors in decreasing order of eigen values
PC1 = [];
for i = 1:m
    ii = idx(i);
    PC1 = [PC1 PC(:,ii)];
end

%from above we can calculate the pca transformation matrix as
pca_transf_mat = x_tilda' * PC1 ; 

% if we need to take required number of principal componenets
pca_transf_mat = pca_transf_mat(:,1:n_pca);
