% jingma
% 02/18/2018

nx1 = 96;
nx2 = 96;
k = 1; % 1 or 5
num = 200;
x1_predict = zeros(1,nx1*nx2);
x2_predict = zeros(1,nx1*nx2);
label_predict = zeros(1,nx1*nx2);

for repx1 = 1:nx1
    x1 = -3.6 + 0.1*repx1;
    for repx2 = 1:nx2
        x2 = -3.1 + 0.1*repx2;
        knn = zeros(k,2);
        knn(:,2) = 100;
        for i = 1:num
            dist_temp = sqrt((x1-data.Xtrain(i,1))^2+(x2-data.Xtrain(i,2))^2);
            [dist_max,dist_argmax] = max(knn(:,2));
            if dist_temp<dist_max
                knn(dist_argmax,1) = data.ytrain(i);
                knn(dist_argmax,2) = dist_temp;
            end
        end
        pos_temp = nx2*(repx1-1)+repx2;
        x1_predict(pos_temp) = x1;
        x2_predict(pos_temp) = x2;
        label_predict(pos_temp) = mode(knn(:,1));
    end
end

figure;
gscatter(x1_predict,x2_predict,label_predict,'rgb');
xlabel('x1');
ylabel('x2');
legend('group1','group2','group3');
