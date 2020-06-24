% jingma
% 03/31/2018

% part (f)
pred_votes = zeros(length(test_label),190); % m = 20, m(m-1)/2 = 190
count = 0;
tic;
for i = 1:20
    for j = (i+1):20
        count = count + 1;
        x_train_e = n_train((train_label==i) | (train_label==j),:);
        y_train_e = train_label((train_label==i) | (train_label==j));
        SVMStruct = svmtrain(x_train_e,y_train_e,'autoscale',false,'boxconstraint',16,'kernelcachelimit',length(vocabulary),'kernel_function','rbf','rbf_sigma',16);
        pred_f = svmclassify(SVMStruct,x_test_e);
        pred_votes(:,count) = pred_f;
    end
end
pred_f = mode(pred_votes,2);
toc;
% (i)
CCR = sum(pred_f==y_test_e)/length(pred_f);
% (iii)
CM = confusionmat(pred_f,y_test_e);
