% jingma
% 04/14/2018

clear;
data = load('./prostateStnd.mat');

x_train = data.Xtrain - mean(data.Xtrain);
y_train = data.ytrain - mean(data.ytrain);
x_test = data.Xtest - mean(data.Xtest);
y_test = data.ytest - mean(data.ytest);

tmax = 100;
w_lasso = zeros(8,16);
mse_train = zeros(16,1);
mse_test = zeros(16,1);

for k = 1:16
    lambda = exp(k-6);
    w = ridge(y_train,x_train,lambda);
    for t = 1:tmax
        temp = w;
        for i = 1:8
            a = 2*sum(x_train(:,i).^2);
            c = 2*sum(x_train(:,i)' * (y_train - x_train*w + x_train(:,i)*w(i)));
            w(i) = sign(c/a)*max(0,abs(c/a)-lambda/a);
        end
        if w == temp
            break;
        end
    end
    w_lasso(:,k) = w;
    h_train = x_train * w;
    mse_train(k) = sum((h_train-y_train).^2)/67;
    h_test = x_test * w;
    mse_test(k) = sum((h_test-y_test).^2)/30; 
end

figure;
plot(-5:10,w_lasso,'-o','LineWidth',1)
xlabel('ln(\lambda)');
ylabel('lasso coefficients');
legend({'w_1','w_2','w_3','w_4','w_5','w_6','w_7','w_8'},'Location','best');

figure;
plot(-5:10,mse_train,'-o','LineWidth',1)
xlabel('ln(\lambda)');
ylabel('mse');
hold on;
plot(-5:10,mse_test,'-o','LineWidth',1)
legend({'train','test'},'Location','best');
% (c)
w_ridge = zeros(8,16);
mse_train = zeros(16,1);
mse_test = zeros(16,1);

for k = 1:16
    lambda = exp(k-6);
    w = ridge(y_train,x_train,lambda);
    w_ridge(:,k) = w;
    h_train = x_train * w;
    mse_train(k) = sum((h_train-y_train).^2)/67;
    h_test = x_test * w;
    mse_test(k) = sum((h_test-y_test).^2)/30; 
end

figure;
plot(-5:10,w_ridge,'-o','LineWidth',1)
xlabel('ln(\lambda)');
ylabel('ridge coefficients');
legend({'w_1','w_2','w_3','w_4','w_5','w_6','w_7','w_8'},'Location','best');

figure;
plot(-5:10,mse_train,'-o','LineWidth',1)
xlabel('ln(\lambda)');
ylabel('mse');
hold on;
plot(-5:10,mse_test,'-o','LineWidth',1)
legend({'train','test'},'Location','best');
