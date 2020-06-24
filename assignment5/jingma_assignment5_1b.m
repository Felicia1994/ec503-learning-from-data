% jingma
% 03/21/2018

d = 42; % # features
m = length(unique(data.Category)); % # classes = 39
tmax = 500;
lambda = 100;
eta = 10^(-5);
train_perc = 0.6;

% features = [features,ones(length(features(:,1)),1)];
% x_train = features(1:length(features(:,1))*train_perc,:);
% y_train = features_short(1:length(features(:,1))*train_perc,4);
% x_test = features(length(features(:,1))*train_perc:length(features(:,1)),:);
% y_test = features_short(length(features(:,1))*train_perc:length(features(:,1)),4);

w = initialize(d,m);
f = zeros(tmax,1);
train_CCR = zeros(tmax,1);
test_CCR = zeros(tmax,1);
test_logloss = zeros(tmax,1);

for i = 1:tmax
    disp(i);
    dw = gradient(w,d,m,x_train,y_train,lambda);
    w = w - eta*dw;
    f(i) = objective(w,m,x_train,y_train,lambda);
    y_train_pred = predict(w,x_train,y_train);
    y_test_pred = predict(w,x_test,y_test);
    train_CCR(i) = CCR(y_train_pred,y_train);
    test_CCR(i) = CCR(y_test_pred,y_test);
    test_logloss(i) = logloss(w,x_test,y_test);
end

figure;
plot(1:tmax,f,'LineWidth',2);
xlabel('iterations');
ylabel('objective');
figure;
subplot(2,2,1);
plot(1:tmax,train_CCR,'LineWidth',2);
xlabel('iterations');
ylabel('train\_CCR');
subplot(2,2,2);
plot(1:tmax,test_CCR,'LineWidth',2);
xlabel('iterations');
ylabel('test\_CCR');
subplot(2,2,3);
plot(1:tmax,test_logloss,'LineWidth',2);
xlabel('iterations');
ylabel('test\_logloss');

figure;
histogram(y_test_pred,'Normalization','pdf');
xticks(1:length(set_category));
xticklabels(set_category);
xtickangle(45);

figure;
histogram(y_test_pred(y_test_pred==y_test),'Normalization','pdf');
xticks(1:length(set_category));
xticklabels(set_category);
xtickangle(45);

%%%%%%%%%%%%%%%%%%%%%% functions %%%%%%%%%%%%%%%%%%%%%%%%%%
function f = initialize(d,m)
    f = zeros(d,m);
end

function f = gradient(w,d,m,x,y,lambda)
    f = zeros(d,m);
    for j = 1:length(y)
        temp = sum(exp( transpose(w) * transpose(x(j,:)) ));
        f = f + transpose( exp(transpose(w)*transpose(x(j,:))) * x(j,:) / temp );
        f(:,y(j)) = f(:,y(j)) - transpose(x(j,:));
    end
    f = f + lambda*w;
end

function f = objective(w,m,x,y,lambda)
    f = 0;
    for j = 1:length(y)
        temp = sum(exp( transpose(w) * transpose(x(j,:)) ));
        f = f + log(temp);
    end
    for k = 1:m
        f = f - sum( transpose(w(:,k)) * transpose(x((y==k),:)) );
        f = f + lambda/2*sum(w(:,k).^2);
    end
end

function f = predict(w,x,y)
    f = zeros(length(y),1);
    for j = 1:length(y)
        [~,temp] = max( transpose(w) * transpose(x(j,:)) );
        f(j) = temp;
    end
end

function f = CCR(y_pred,y)
    f = sum(y_pred==y) / length(y);
end

function f = logloss(w,x,y)
    f = 0;
    for j = 1:length(y)
        temp = sum(exp( transpose(w) * transpose(x(j,:)) ));
        f = f + log(max( 10^(-10) , exp(transpose(w(:,y(j)))*transpose(x(j,:))) / temp ));
    end
    f = -f/length(y);
end

