% jingma
% 04/14/2018

clear;
data = load('./housing_data.mat');
% (a)
tree = fitrtree(data.Xtrain,data.ytrain,'MinLeafSize',20);
view(tree,'Mode','graph');
% (b)
pred = predict(tree,[5,18,2.31,1,0.5440,2,64,3.7,1,300,15,390,10]);
% (c)
mae_train = zeros(25,1);
mae_test = zeros(25,1);
for i = 1:25
    tree = fitrtree(data.Xtrain,data.ytrain,'MinLeafSize',i);
    h_train = predict(tree,data.Xtrain);
    mae_train(i) = sum(abs(h_train-data.ytrain))/253;
    h_test = predict(tree,data.Xtest);
    mae_test(i) = sum(abs(h_test-data.ytest))/253;
end

figure;
plot(1:25,mae_train,'-o','LineWidth',1);
xlabel('MinLeafSize');
ylabel('mae');
hold on;
plot(1:25,mae_test,'-o','LineWidth',1);
legend({'train','test'},'Location','best');
