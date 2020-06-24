function [Y_predict] = jingma_QDA_test(X_test, QDAmodel, numofClass)
%
% Testing for QDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_test : test data matrix, each row is a test data point
% numofClass : number of classes 
% QDAmodel: the parameters of QDA classifier which has the following fields
% QDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% QDAmodel.Sigma : D * D * numofClass array, Sigma(:,:,i) = covariance
% matrix of class i
% QDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i
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
        muxy = transpose(QDAmodel.Mu(j,:));
        sigmaxy = QDAmodel.Sigma(:,:,j);
        pi = QDAmodel.Pi(j);
        apos(j) = transpose(x-muxy)/sigmaxy*(x-muxy)/2 + log(det(sigmaxy))/2 - log(pi);
    end
    [~, Y_predict(i)] = min(apos);
end
Y_predict = transpose(Y_predict);

end
