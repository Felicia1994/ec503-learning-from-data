% jingma
% 02/18/2018

data_train = load('./data_mnist_train.mat');
data_test = load('./data_mnist_test.mat');

num_train = length(data_train.X_train(:,1));
num_test = length(data_test.X_test(:,1));

Y_predict = zeros(num_test,1);

for test_image = 1:num_test
    dist_sqr = sum((data_test.X_test(test_image,:) - data_train.X_train).^2,2);
    [~,argmin] = min(dist_sqr);
    Y_predict(test_image) = data_train.Y_train(argmin);
end

CCR = sum(data_test.Y_test==Y_predict)/num_test;
CM = confusionmat(data_test.Y_test,Y_predict);
