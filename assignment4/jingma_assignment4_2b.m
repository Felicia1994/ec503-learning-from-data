% jingma
% 02/28/2018

num_classes = length(unique(train_label));
beta = zeros(unique_entire,num_classes);
beta0 = zeros(1,num_classes);

for i = 1:length(train_label) % i denotes the i-th document
    c = train_label(i); % c is the label of the i-th document
    beta0(1,c) = beta0(1,c) + 1;
    temp = train_data(train_data(:,1)==i,:); % temp is the train_data corresponding to the i-th document
    for j = 1:length(temp(:,1))
        beta(temp(j,2),c) = beta(temp(j,2),c) + temp(j,3);
    end
end

beta = beta./sum(beta);
beta0 = beta0/sum(beta0);
%
figure;
plot(beta0,'o','LineWidth',2);
xlabel('label');
ylabel('prior probabilities');
%
num_zeros = sum(sum(beta==0));
%
test_predict = zeros(length(unique(test_data(:,1))),1);
count_zeros = 0;

for i = 1:length(unique(test_data(:,1))) % i denotes the i-th document
    temp = test_data(test_data(:,1)==i,:); % temp is the test_data corresponding to the i-th document
    prob = beta0;
    for j = 1:length(temp(:,1))
        prob = prob.*(beta(temp(j,2),:).^temp(j,3));
    end
    [max_prob,max_label] = max(prob);
    if max_prob==0
        count_zeros = count_zeros + 1;
    end
    if sum(prob==max_prob) == num_classes
        [~,max_label] = max(beta0);
    end
    test_predict(i,1) = max_label;
end
%
CCR = sum(test_label==test_predict)/length(test_label);
%
CM = confusionmat(test_label,test_predict);
