function [Y_predict] = jingma_RDA_test(X_test, RDAmodel, numofClass)
%
% Testing for RDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_test : test data matrix, each row is a test data point
% numofClass : number of classes 
% RDAmodel : the parameters of RDA classifier which has the following fields
% RDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% RDAmodel.Sigmapooled : D * D  covariance matrix 
% RDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i
%
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% Y_predict predicted labels for all the testing data points in X_test

% Write your code here:

[n,~] = size(X_test);

Y_predict = zeros(1,n);

for i = 1:n
    x = transpose(X_test(i,:));
    apos = zeros(1,numofClass);
    for j = 1:numofClass
        muxy = transpose(RDAmodel.Mu(j,:));
        sigmax = RDAmodel.Sigma;
        pi = RDAmodel.Pi(j);
        apos(j) = transpose(muxy)/sigmax*x - transpose(muxy)/sigmax*muxy/2 + log(pi);
    end
    [~, Y_predict(i)] = max(apos);
end
Y_predict = transpose(Y_predict);

end
