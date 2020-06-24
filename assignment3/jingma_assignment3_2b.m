% jingma
% 02/16/2018

data = load('./data_iris.mat');
numofClass = 3;
D = 4;
repeats = 10;
num_total = 150;
num_train = 100;
num_test = num_total - num_train;


% preallocation
QDA_M = zeros(numofClass,D);
LDA_M = zeros(numofClass,D);
QDA_V = zeros(numofClass,D);
LDA_V = zeros(1,D);
QDA_CCR = zeros(1,repeats);
LDA_CCR = zeros(1,repeats);
LDA_CM = zeros(numofClass,numofClass,repeats);
max_LDA_CCR = -0.1;
min_LDA_CCR = 1.1;

for rep = 1:repeats
    % train test split
    train = randperm(num_total,num_train);
    test = 1:num_total;
    test(train) = [];
    X_train = data.X(train,:);
    Y_train = data.Y(train);
    X_test = data.X(test,:);
    Y_test = data.Y(test);
    % QDA
    QDAmodel = jingma_QDA_train(X_train,Y_train,numofClass);
    QDA_predict = jingma_QDA_test(X_test,QDAmodel,numofClass);
    QDA_CCR_temp = sum(Y_test==QDA_predict)/num_test;
    QDA_CCR(rep) = QDA_CCR_temp;
    QDA_CM = confusionmat(Y_test,QDA_predict);
    QDA_M = QDA_M + QDAmodel.Mu;
    QDA_V_temp = zeros(numofClass,D);
    for j = 1:numofClass
        QDA_V_temp(j,:) = transpose(diag(QDAmodel.Sigma(:,:,j)));
    end
    QDA_V = QDA_V + QDA_V_temp;
    % LDA
    LDAmodel = jingma_LDA_train(X_train,Y_train,numofClass);
    LDA_predict = jingma_LDA_test(X_test,LDAmodel,numofClass);
    LDA_CCR_temp = sum(Y_test==LDA_predict)/num_test;
    LDA_CCR(rep) = LDA_CCR_temp;
    LDA_CM_temp = confusionmat(Y_test,LDA_predict);
    LDA_CM(:,:,rep) = LDA_CM_temp;
    if LDA_CCR_temp>max_LDA_CCR
        max_LDA_CCR = LDA_CCR_temp;
        LDA_CM_best = LDA_CM_temp;
    end
    if LDA_CCR_temp<min_LDA_CCR
        min_LDA_CCR = LDA_CCR_temp;
        LDA_CM_worst = LDA_CM_temp;
    end
    LDA_M = LDA_M + LDAmodel.Mu;
    LDA_V = LDA_V + transpose(diag(LDAmodel.Sigma));
end

QDA_M = QDA_M/repeats;
LDA_M = LDA_M/repeats;
QDA_V = QDA_V/repeats;
LDA_V = LDA_V/repeats;

QDA_CCR_Mean = mean(QDA_CCR);
QDA_CCR_Std = std(QDA_CCR);
LDA_CCR_Mean = mean(LDA_CCR);
LDA_CCR_Std = std(LDA_CCR);
