function [Y_predict] = jingma_LDA_test(X_test, LDAmodel, numofClass)
%
% Testing for LDA
%
% EC 503 Learning from Data
% Gaussian Discriminant Analysis
%
% Assuming D = dimension of data
% Inputs :
% X_test : test data matrix, each row is a test data point
% numofClass : number of classes 
% LDAmodel : the parameters of LDA classifier which has the follwoing fields
% LDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% LDAmodel.Sigmapooled : D * D  covariance matrix
% LDAmodel.Pi : numofClass * 1 vector, Pi(i) = prior probability of class i
%
% Assuming that the classes are labeled  from 1 to numofClass
% Output :
% Y_predict predicted labels for all the testing data points in X_test

% Write your codes here:

[n,~] = size(X_test);

Y_predict = zeros(1,n);

for i = 1:n
    x = transpose(X_test(i,:));
    apos = zeros(1,numofClass);
    for j = 1:numofClass
        muxy = transpose(LDAmodel.Mu(j,:));
        sigmax = LDAmodel.Sigma;
        pi = LDAmodel.Pi(j);
        apos(j) = transpose(muxy)/sigmax*x - transpose(muxy)/sigmax*muxy/2 + log(pi);
    end
    [~, Y_predict(i)] = max(apos);
end
Y_predict = transpose(Y_predict);

end
