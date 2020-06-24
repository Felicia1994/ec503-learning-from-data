function [QDAmodel] = jingma_QDA_train(X_train, Y_train, numofClass)
%
% Training QDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_train : training data matrix, each row is a training data point
% Y_train : training labels for rows of X_train
% numofClass : number of classes 
%
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% QDAmodel : the parameters of QDA classifier which has the following fields
% QDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% QDAmodel.Sigma : D * D * numofClass array, Sigma(:,:,i) = covariance matrix of class i
% QDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i

% Write your code here:

x = transpose(X_train);
y = transpose(Y_train);
n = length(y);

QDAmodel.Mu = [];
QDAmodel.Sigma = [];
QDAmodel.Pi = [];

for i = 1:numofClass
    ny = sum(y==i);
    xy = x(:,y==i);
    muxy = xy*ones(ny,1)/n;
    QDAmodel.Mu(i,:) = transpose(muxy);
    xytilde = xy*(eye(ny)-ones(ny,1)*transpose(ones(ny,1))/ny);
    sigmaxy = xytilde*transpose(xytilde)/ny;
    QDAmodel.Sigma(:,:,i) = sigmaxy;
    py = ny/n;
    QDAmodel.Pi(i) = py;
end
QDAmodel.Pi = transpose(QDAmodel.Pi);

end
