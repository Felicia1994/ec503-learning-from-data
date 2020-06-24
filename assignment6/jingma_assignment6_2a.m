% jingma
% 03/31/2018

% load files
clear;
train_data = load('./train.data');
test_data = load('./test.data');
train_label = load('./train.label');
test_label = load('./test.label');
vocabulary = textread('./vocabulary.txt','%s');
newsgrouplabels = textread('./newsgrouplabels.txt','%s');
stoplist = textread('./stoplist.txt','%s');
% initialize
num_train = length(train_label);
num_test = length(test_label);
num_words = length(vocabulary);
n_train = zeros(num_words,num_train);
n_test = zeros(num_words,num_test);
% update n_train and n_test
for i = 1:length(train_data(:,1))
    n_train(train_data(i,2),train_data(i,1)) = train_data(i,3);
end
for i = 1:length(test_data(:,1))
    n_test(test_data(i,2),test_data(i,1)) = test_data(i,3);
end
% remove stop words
for i = 1:num_words
    if ismember(vocabulary(i),stoplist)
        n_train(i,1) = -1;
        n_test(i,1) = -1;
    end
end
n_train(n_train(:,1)==-1,:) = [];
n_test(n_test(:,1)==-1,:) = [];
% sparsify matrices
n_train = sparse(transpose(n_train));
n_test = sparse(transpose(n_test));
% part (a)
x_train_a = n_train((train_label==1) | (train_label==20),:);
y_train_a = train_label((train_label==1) | (train_label==20));
x_test_a = n_test((test_label==1) | (test_label==20),:);
y_test_a = test_label((test_label==1) | (test_label==20));
cv_a = cvpartition(length(y_train_a),'KFold',5);
cv_CCR = zeros(20,1);
for k = 1:20
    c = 2^(k-10);
    for i = 1:5
        SVMStruct = svmtrain(x_train_a(cv_a.training(i),:),y_train_a(cv_a.training(i)),'autoscale',false,'boxconstraint',c*ones(sum(cv_a.training(i)),1),'kernelcachelimit',length(vocabulary),'kernel_function','linear');
        pred_a = svmclassify(SVMStruct,x_train_a(cv_a.test(i),:));
        temp = sum(pred_a==y_train_a(cv_a.test(i)))/length(pred_a);
        cv_CCR(k) = cv_CCR(k) + temp/5;
    end
end
% (i)
figure;
semilogx(2.^(-9:10),cv_CCR,'o-','LineWidth',2);
xlabel('C');
ylabel('CV\_CCR');
% (ii)
[~,temp] = max(cv_CCR);
c = 2^(temp-10);
% (iii)
SVMStruct = svmtrain(x_train_a,y_train_a,'autoscale',false,'boxconstraint',c*ones(length(y_train_a),1),'kernelcachelimit',length(vocabulary),'kernel_function','linear');
pred_a = svmclassify(SVMStruct,x_test_a);
CCR = sum(pred_a==y_test_a)/length(pred_a);
