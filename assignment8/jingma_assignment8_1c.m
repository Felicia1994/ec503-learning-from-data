% jingma
% 04/19/2018

Data3 = zeros(1500,2);
[Data3(:,1), Data3(:,2)] = cart2pol(Data1(:,1), Data1(:,2));

Data3(:,1) = (Data3(:,1)-min(Data3(:,1))) / (max(Data3(:,1))-min(Data3(:,1)));
Data3(:,2) = (Data3(:,2)-min(Data3(:,2))) / (max(Data3(:,2))-min(Data3(:,2)));
% (i)
rng(2);
[P3_2, C3_2] = kmeans(Data3,2,'Distance','cityblock','Replicates',20);
rng(2);
[P3_3, C3_3] = kmeans(Data3,3,'Distance','cityblock','Replicates',20);
rng(2);
[P3_4, C3_4] = kmeans(Data3,4,'Distance','cityblock','Replicates',20);

figure;

subplot(1,3,1);
gscatter(Data3(:,1),Data3(:,2),P3_2,'rb');
hold on;
plot(C3_2(:,1),C3_2(:,2),'*c');
legend('off');

subplot(1,3,2);
gscatter(Data3(:,1),Data3(:,2),P3_3,'rbg');
hold on;
plot(C3_3(:,1),C3_3(:,2),'*c');
legend('off');

subplot(1,3,3);
gscatter(Data3(:,1),Data3(:,2),P3_4,'rbgk');
hold on;
plot(C3_4(:,1),C3_4(:,2),'*c');
legend('off');
% (ii)
sqdist3_2_1 = sum(sum(abs(Data3(P3_2==1,:)-C3_2(1,:))));
sqdist3_2_2 = sum(sum(abs(Data3(P3_2==2,:)-C3_2(2,:))));

sqdist3_3_1 = sum(sum(abs(Data3(P3_3==1,:)-C3_3(1,:))));
sqdist3_3_2 = sum(sum(abs(Data3(P3_3==2,:)-C3_3(2,:))));
sqdist3_3_3 = sum(sum(abs(Data3(P3_3==3,:)-C3_3(3,:))));

sqdist3_4_1 = sum(sum(abs(Data3(P3_4==1,:)-C3_4(1,:))));
sqdist3_4_2 = sum(sum(abs(Data3(P3_4==2,:)-C3_4(2,:))));
sqdist3_4_3 = sum(sum(abs(Data3(P3_4==3,:)-C3_4(3,:))));
sqdist3_4_4 = sum(sum(abs(Data3(P3_4==4,:)-C3_4(4,:))));
