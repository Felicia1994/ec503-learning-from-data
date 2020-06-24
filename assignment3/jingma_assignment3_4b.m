% jingma
% 02/18/2018

nx1 = 96;
nx2 = 96;
k = 10;
num = 200;
group_num = 2; % 2 or 3
probability_predict = zeros(nx2,nx1);

for repx1 = 1:nx1
    x1 = -3.6 + 0.1*repx1;
    for repx2 = 1:nx2
        x2 = 6.6 - 0.1*repx2;
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
        probability_predict(repx2,repx1) = sum(knn(:,1)==group_num)/k;
    end
end

figure;
imagesc([-3.5,6],[6.5,-3],probability_predict);
colorbar;
set(gca,'YDir','normal');


