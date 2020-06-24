% jingma
% 03/31/2018

% part (b)
cv_CCR = zeros(17,21);
for j = 1:21
    c = 2^(j-8);
    for k = 1:17
        rbf_sigma = 2^(k-8);
        for i = 1:5
            SVMStruct = svmtrain(x_train_a(cv_a.training(i),:),y_train_a(cv_a.training(i)),'autoscale',false,'boxconstraint',c*ones(sum(cv_a.training(i)),1),'kernelcachelimit',length(vocabulary),'kernel_function','rbf','rbf_sigma',rbf_sigma);
            pred_a = svmclassify(SVMStruct,x_train_a(cv_a.test(i),:));
            temp = sum(pred_a==y_train_a(cv_a.test(i)))/length(pred_a);
            cv_CCR(k,j) = cv_CCR(k,j) + temp/5;
        end
    end
end
% (i)
figure;
[h1,h2] = contour(-7:13,-7:9,cv_CCR,'LineWidth',2);
clabel(h1,h2);
colorbar;
xlabel('log2(C)');
ylabel('log2(rbf\_sigma)');
% (ii)
[~,temp] = max(max(cv_CCR));
c = 2^(temp-8);
[~,temp] = max(max(cv_CCR'));
rbf_sigma = 2^(temp-8);
% (iii)
SVMStruct = svmtrain(x_train_a,y_train_a,'autoscale',false,'boxconstraint',c*ones(length(y_train_a),1),'kernelcachelimit',length(vocabulary),'kernel_function','rbf','rbf_sigma',rbf_sigma);
pred_a = svmclassify(SVMStruct,x_test_a);
CCR = sum(pred_a==y_test_a)/length(pred_a);
