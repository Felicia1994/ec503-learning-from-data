% jingma
% 04/14/2018

clear;
data = load('./quad_data.mat');

% (a)
x_train = zeros(21,14);
for i = 1:14
    x_train(:,i) = data.xtrain.^i;
end
x_test = zeros(201,14);
for i = 1:14
    x_test(:,i) = data.xtest.^i;
end

b_2 = ridge(data.ytrain,x_train(:,1:2),0,0);
b_6 = ridge(data.ytrain,x_train(:,1:6),0,0);
b_10 = ridge(data.ytrain,x_train(:,1:10),0,0);
b_14 = ridge(data.ytrain,x_train(:,1:14),0,0);

xticks = 0:0.1:20;
curve_2 = zeros(1,length(xticks));
for i = 0:2
    curve_2 = curve_2 + b_2(i+1)*xticks.^i;
end
curve_6 = zeros(1,length(xticks));
for i = 0:6
    curve_6 = curve_6 + b_6(i+1)*xticks.^i;
end
curve_10 = zeros(1,length(xticks));
for i = 0:10
    curve_10 = curve_10 + b_10(i+1)*xticks.^i;
end
curve_14 = zeros(1,length(xticks));
for i = 0:14
    curve_14 = curve_14 + b_14(i+1)*xticks.^i;
end

figure;
plot(data.xtrain,data.ytrain,'o','LineWidth',1);
xlim([0,20]);
xlabel('x');
ylabel('y');
hold on;
plot(xticks,curve_2,'LineWidth',1);
plot(xticks,curve_6,'LineWidth',1);
plot(xticks,curve_10,'LineWidth',1);
plot(xticks,curve_14,'LineWidth',1);
legend({'data','d=2','d=6','d=10','d=14'},'Location','southeast');

mse_train = zeros(14,1);
mse_test = zeros(14,1);
for i = 1:14
    b = ridge(data.ytrain,x_train(:,1:i),0,0);
    h_train = [ones(21,1),x_train(:,1:i)] * b;
    h_test = [ones(201,1),x_test(:,1:i)] * b;
    mse_train(i) = sum((h_train-data.ytrain).^2)/21;
    mse_test(i) = sum((h_test-data.ytest).^2)/201;
end

figure;
plot(1:14,mse_train,'-o','LineWidth',1);
xlabel('d');
ylabel('mse');
hold on;
plot(1:14,mse_test,'-o','LineWidth',1);
legend({'train','test'});

% (b)
mse_train = zeros(31,1);
mse_test = zeros(31,1);
for i = 1:31
    lambda = exp(i-26);
    b = ridge(data.ytrain,x_train(:,1:10),lambda,0);
    h_train = [ones(21,1),x_train(:,1:10)] * b;
    h_test = [ones(201,1),x_test(:,1:10)] * b;
    mse_train(i) = sum((h_train-data.ytrain).^2)/21;
    mse_test(i) = sum((h_test-data.ytest).^2)/201;
end

figure;
plot(-25:5,mse_train,'-o','LineWidth',1);
xlabel('ln(\lambda)');
ylabel('mse');
hold on;
plot(-25:5,mse_test,'-o','LineWidth',1);
legend({'train','test'},'Location','best');
% (ii)
h_test_ols_10 = [ones(201,1),x_test(:,1:10)] * b_10;
b_ridge = ridge(data.ytrain,x_train(:,1:10),exp(23-26),0);
h_test_ridge_10 = [ones(201,1),x_test(:,1:10)] * b_ridge;

figure;
plot(data.xtest,data.ytest,'o','LineWidth',1)
xlabel('x');
ylabel('y');
hold on;
plot(data.xtest,h_test_ols_10,'-o','LineWidth',1);
plot(data.xtest,h_test_ridge_10,'-o','LineWidth',1);
legend({'test data','d=10 polynomial','d=10,ln(\lambda)=-3 l_2-regularized'},'Location','best');
% (c)
b = ridge(data.ytrain,x_train(:,1:4),exp(-25:5),0);

figure;
plot(-25:5,b,'-o','LineWidth',1);
xlabel('ln(\lambda)');
ylabel('w');
legend({'w_0','w_1','w_2','w_3','w_4'},'Location','best');
