% jingma
% 04/19/2018

clear;
[Data1,Label1] = sample_circle(3,[500,500,500]);
[Data2,Label2] = sample_spiral(3,[500,500,500]);
% (i)
rng(2);
[P1_2, C1_2] = kmeans(Data1,2,'Distance','sqeuclidean','Replicates',20);
rng(2);
[P1_3, C1_3] = kmeans(Data1,3,'Distance','sqeuclidean','Replicates',20);
rng(2);
[P1_4, C1_4] = kmeans(Data1,4,'Distance','sqeuclidean','Replicates',20);
rng(2);
[P2_2, C2_2] = kmeans(Data2,2,'Distance','sqeuclidean','Replicates',20);
rng(2);
[P2_3, C2_3] = kmeans(Data2,3,'Distance','sqeuclidean','Replicates',20);
rng(2);
[P2_4, C2_4] = kmeans(Data2,4,'Distance','sqeuclidean','Replicates',20);

figure;

subplot(2,3,1);
gscatter(Data1(:,1),Data1(:,2),P1_2,'rb');
hold on;
plot(C1_2(:,1),C1_2(:,2),'*c');
legend('off');

subplot(2,3,2);
gscatter(Data1(:,1),Data1(:,2),P1_3,'rbg');
hold on;
plot(C1_3(:,1),C1_3(:,2),'*c');
legend('off');

subplot(2,3,3);
gscatter(Data1(:,1),Data1(:,2),P1_4,'rbgk');
hold on;
plot(C1_4(:,1),C1_4(:,2),'*c');
legend('off');

subplot(2,3,4);
gscatter(Data2(:,1),Data2(:,2),P2_2,'rb');
xlim([-6,6]);
hold on;
plot(C2_2(:,1),C2_2(:,2),'*c');
legend('off');

subplot(2,3,5);
gscatter(Data2(:,1),Data2(:,2),P2_3,'rbg');
xlim([-6,6]);
hold on;
plot(C2_3(:,1),C2_3(:,2),'*c');
legend('off');

subplot(2,3,6);
gscatter(Data2(:,1),Data2(:,2),P2_4,'rbgk');
xlim([-6,6]);
hold on;
plot(C2_4(:,1),C2_4(:,2),'*c');
legend('off');
% (ii)
sqdist1_2_1 = sum(sum((Data1(P1_2==1,:)-C1_2(1,:)).^2));
sqdist1_2_2 = sum(sum((Data1(P1_2==2,:)-C1_2(2,:)).^2));

sqdist1_3_1 = sum(sum((Data1(P1_3==1,:)-C1_3(1,:)).^2));
sqdist1_3_2 = sum(sum((Data1(P1_3==2,:)-C1_3(2,:)).^2));
sqdist1_3_3 = sum(sum((Data1(P1_3==3,:)-C1_3(3,:)).^2));

sqdist1_4_1 = sum(sum((Data1(P1_4==1,:)-C1_4(1,:)).^2));
sqdist1_4_2 = sum(sum((Data1(P1_4==2,:)-C1_4(2,:)).^2));
sqdist1_4_3 = sum(sum((Data1(P1_4==3,:)-C1_4(3,:)).^2));
sqdist1_4_4 = sum(sum((Data1(P1_4==4,:)-C1_4(4,:)).^2));

sqdist2_2_1 = sum(sum((Data2(P2_2==1,:)-C2_2(1,:)).^2));
sqdist2_2_2 = sum(sum((Data2(P2_2==2,:)-C2_2(2,:)).^2));

sqdist2_3_1 = sum(sum((Data2(P2_3==1,:)-C2_3(1,:)).^2));
sqdist2_3_2 = sum(sum((Data2(P2_3==2,:)-C2_3(2,:)).^2));
sqdist2_3_3 = sum(sum((Data2(P2_3==3,:)-C2_3(3,:)).^2));

sqdist2_4_1 = sum(sum((Data2(P2_4==1,:)-C2_4(1,:)).^2));
sqdist2_4_2 = sum(sum((Data2(P2_4==2,:)-C2_4(2,:)).^2));
sqdist2_4_3 = sum(sum((Data2(P2_4==3,:)-C2_4(3,:)).^2));
sqdist2_4_4 = sum(sum((Data2(P2_4==4,:)-C2_4(4,:)).^2));
