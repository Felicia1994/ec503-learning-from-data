function [RDAmodel]= jingma_RDA_train(X_train, Y_train, gamma, numofClass)
%
% Training RDA
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
% RDAmodel : the parameters of RDA classifier which has the following fields
% RDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% RDAmodel.Sigmapooled : D * D  covariance matrix
% RDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i

% Write your code here:

x = transpose(X_train);
y = transpose(Y_train);
n = length(y);

RDAmodel.Mu = [];
RDAmodel.Sigma = [];
RDAmodel.Pi = [];

for i = 1:numofClass
    ny = sum(y==i);
    xy = x(:,y==i);
    muxy = xy*ones(ny,1)/n;
    RDAmodel.Mu(i,:) = transpose(muxy);
    py = ny/n;
    RDAmodel.Pi(i) = py;
end
RDAmodel.Pi = transpose(RDAmodel.Pi);

xtilde = x*(eye(n)-ones(n,1)*transpose(ones(n,1))/n);
sigmax = xtilde*transpose(xtilde)/n;
RDAmodel.Sigma = gamma*diag(diag(sigmax)) + (1-gamma)*sigmax;

end
