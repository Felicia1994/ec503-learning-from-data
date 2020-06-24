% jingma
% 03/31/2018

% part (e)
pred_votes = zeros(length(test_label),190); % m = 20, m(m-1)/2 = 190
x_test_e = n_test;
y_test_e = test_label;
count = 0;
tic;
for i = 1:20
    for j = (i+1):20
        count = count + 1;
        x_train_e = n_train((train_label==i) | (train_label==j),:);
        y_train_e = train_label((train_label==i) | (train_label==j));
        SVMStruct = svmtrain(x_train_e,y_train_e,'autoscale',false,'kernelcachelimit',length(vocabulary),'kernel_function','linear');
        pred_e = svmclassify(SVMStruct,x_test_e);
        pred_votes(:,count) = pred_e;
    end
end
pred_e = mode(pred_votes,2);
toc;
% (i)
CCR = sum(pred_e==y_test_e)/length(pred_e);
% (iii)
CM = confusionmat(pred_e,y_test_e);
