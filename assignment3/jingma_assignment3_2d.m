% jingma
% 02/16/2018

data = load('./data_cancer.mat');
numofClass = 3;
D = 4000;
repeats = 19;
num_total = 216;
num_train = 150;
num_test = num_total - num_train;

% preallocation
RDA_CCR_train = zeros(1,repeats);
RDA_CCR_test = zeros(1,repeats);
s = RandStream('mt19937ar','Seed',0);

for rep = 1:repeats
    gamma = 0.05*rep + 0.05;
    % train test split
    train = randperm(s,num_total,num_train);
    test = 1:num_total;
    test(train) = [];
    X_train = data.X(train,:);
    Y_train = data.Y(train);
    X_test = data.X(test,:);
    Y_test = data.Y(test);
    % RDA
    RDAmodel = jingma_RDA_train(X_train,Y_train,gamma,numofClass);
    RDA_predict_train = jingma_RDA_test(X_train,RDAmodel,numofClass);
    RDA_predict_test = jingma_RDA_test(X_test,RDAmodel,numofClass);
    RDA_CCR_train_temp = sum(Y_train==RDA_predict_train)/num_train;
    RDA_CCR_test_temp = sum(Y_test==RDA_predict_test)/num_test;
    RDA_CCR_train(rep) = RDA_CCR_train_temp;
    RDA_CCR_test(rep) = RDA_CCR_test_temp;
end

figure;
plot(0.1:0.05:1,RDA_CCR_train,'-ok','LineWidth',2);
hold on;
plot(0.1:0.05:1,RDA_CCR_test,'--ok','LineWidth',2);
xlabel('lambda');
ylabel('RDA\_CCR');
legend('train','test');
