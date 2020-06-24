% jingma
% 02/16/2018

data = load('./data_knnSimulation.mat');
gscatter(data.Xtrain(:,1),data.Xtrain(:,2),data.ytrain,'rgb');