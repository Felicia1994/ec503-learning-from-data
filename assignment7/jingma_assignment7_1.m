% jingma
% 04/14/2018

clear;
data = load('./linear_data.mat');
x = data.xData'; % d*n, d=1
y = data.yData'; % 1*n
n = length(y);

% (a)
mu_x = mean(x);
mu_y = mean(y);
sigma_x = (x-mu_x) * transpose(x-mu_x) / n;
sigma_xy = (x-mu_x) * transpose(y-mu_y) / n;
w_ols = sigma_xy / sigma_x;
b_ols = mu_y - w_ols * mu_x;
h_ols = x' * w_ols + b_ols; % n*1
mse_ols = sum((y'-h_ols).^2) / n;
mae_ols = sum(abs(y'-h_ols)) / n;
% (b)
b_cauchy = robustfit(x',y','cauchy');
h_cauchy = [ones(1,n);x]' * b_cauchy; % n*1
mse_cauchy = sum((y'-h_cauchy).^2) / n;
mae_cauchy = sum(abs(y'-h_cauchy)) / n;

b_fair = robustfit(x',y','fair');
h_fair = [ones(1,n);x]' * b_fair; % n*1
mse_fair = sum((y'-h_fair).^2) / n;
mae_fair = sum(abs(y'-h_fair)) / n;

b_huber = robustfit(x',y','huber');
h_huber = [ones(1,n);x]' * b_huber; % n*1
mse_huber = sum((y'-h_huber).^2) / n;
mae_huber = sum(abs(y'-h_huber)) / n;

b_talwar = robustfit(x',y','talwar');
h_talwar = [ones(1,n);x]' * b_talwar; % n*1
mse_talwar = sum((y'-h_talwar).^2) / n;
mae_talwar = sum(abs(y'-h_talwar)) / n;

figure;
plot(x,y,'o','LineWidth',1);
xlim([-2,2]);
xlabel('x');
ylabel('y');
hold on;
plot(-2:2,b_ols + w_ols*(-2:2),'LineWidth',1);
plot(-2:2,b_cauchy(1) + b_cauchy(2)*(-2:2),'LineWidth',1);
plot(-2:2,b_fair(1) + b_fair(2)*(-2:2),'LineWidth',1);
plot(-2:2,b_huber(1) + b_huber(2)*(-2:2),'LineWidth',1);
plot(-2:2,b_talwar(1) + b_talwar(2)*(-2:2),'LineWidth',1);
legend({'data','ols','cauchy','fair','huber','talwar'},'Location','southwest');

figure;
bar(categorical({'ols','cauchy','fair','huber','talwar'}),[mse_ols,mae_ols;mse_cauchy,mae_cauchy;mse_fair,mae_fair;mse_huber,mae_huber;mse_talwar,mae_talwar]);
legend({'mse','mae'});
