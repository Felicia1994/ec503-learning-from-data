% jingma
% 04/19/2018

sigma = 0.2;
W1 = zeros(1500,1500);
for i = 1:1500
    for j = i:1500
        temp = exp(- sum((Data1(i,:)-Data1(j,:)).^2) / (2*sigma^2));
        W1(i,j) = temp;
        W1(j,i) = temp;
    end
end
D1 = diag(W1 * ones(1500,1));
L1 = D1 - W1;
Lrw1 = diag(diag(D1).^(-1)) * L1;
Lsym1 = diag(diag(D1).^(-0.5)) * L1 * diag(diag(D1).^(-0.5));

W2 = zeros(1500,1500);
for i = 1:1500
    for j = i:1500
        temp = exp(- sum((Data2(i,:)-Data2(j,:)).^2) / (2*sigma^2));
        W2(i,j) = temp;
        W2(j,i) = temp;
    end
end
D2 = diag(W2 * ones(1500,1));
L2 = D2 - W2;
Lrw2 = diag(diag(D2).^(-1)) * L2;
Lsym2 = diag(diag(D2).^(-0.5)) * L2 * diag(diag(D2).^(-0.5));

% (i)
[eig_vec1,eig_val1] = eig(L1);
[eig_vecrw1,eig_valrw1] = eig(Lrw1);
[eig_vecsym1,eig_valsym1] = eig(Lsym1);

[eig_vec2,eig_val2] = eig(L2);
[eig_vecrw2,eig_valrw2] = eig(Lrw2);
[eig_vecsym2,eig_valsym2] = eig(Lsym2);

figure;

subplot(2,3,1);
plot(sort(real(diag(eig_val1))),'LineWidth',2);

subplot(2,3,2);
plot(sort(real(diag(eig_valrw1))),'LineWidth',2);

subplot(2,3,3);
plot(sort(real(diag(eig_valsym1))),'LineWidth',2);

subplot(2,3,4);
plot(sort(real(diag(eig_val2))),'LineWidth',2);

subplot(2,3,5);
plot(sort(real(diag(eig_valrw2))),'LineWidth',2);

subplot(2,3,6);
plot(sort(real(diag(eig_valsym2))),'LineWidth',2);

% (ii)
figure;

for k = 2:4
    temp = sort(real(diag(eig_valsym1)));
    v = zeros(1500,k);
    for i = 1:k
        v(:,i) = eig_vecsym1(:,real(diag(eig_valsym1))==temp(i));
    end
    v = v ./ sqrt(sum(v.^2,2));
    rng(2);
    [p, c] = kmeans(v,k);
    subplot(2,3,k-1);
    gscatter(Data1(:,1),Data1(:,2),p,'rbgk');
    legend('off');
end

for k = 2:4
    temp = sort(real(diag(eig_valsym2)));
    v = zeros(1500,k);
    for i = 1:k
        v(:,i) = eig_vecsym2(:,real(diag(eig_valsym2))==temp(i));
    end
    v = v ./ sqrt(sum(v.^2,2));
    rng(2);
    [p, c] = kmeans(v,k);
    subplot(2,3,k+2);
    gscatter(Data2(:,1),Data2(:,2),p,'rbgk');
    xlim([-6,6]);
    legend('off');
end
% (iii)
k = 3;
figure;
% 1st
temp = sort(real(diag(eig_val1)));
v = zeros(1500,k);
for i = 1:k
    v(:,i) = eig_vec1(:,real(diag(eig_val1))==temp(i));
end
rng(2);
[p, c] = kmeans(v,k);
subplot(2,3,1);

temp = v(p==1,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.r');
hold on;
temp = v(p==2,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.b');
temp = v(p==3,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.g');
% 2nd
temp = sort(real(diag(eig_valrw1)));
v = zeros(1500,k);
for i = 1:k
    v(:,i) = eig_vecrw1(:,real(diag(eig_valrw1))==temp(i));
end
rng(2);
[p, c] = kmeans(v,k);
subplot(2,3,2);

temp = v(p==1,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.r');
hold on;
temp = v(p==2,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.b');
temp = v(p==3,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.g');
% 3rd
temp = sort(real(diag(eig_valsym1)));
v = zeros(1500,k);
for i = 1:k
    v(:,i) = eig_vecsym1(:,real(diag(eig_valsym1))==temp(i));
end
v = v ./ sqrt(sum(v.^2,2));
rng(2);
[p, c] = kmeans(v,k);
subplot(2,3,3);

temp = v(p==1,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.r');
hold on;
temp = v(p==2,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.b');
temp = v(p==3,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.g');
% 4th
temp = sort(real(diag(eig_val2)));
v = zeros(1500,k);
for i = 1:k
    v(:,i) = eig_vec2(:,real(diag(eig_val2))==temp(i));
end
rng(2);
[p, c] = kmeans(v,k);
subplot(2,3,4);

temp = v(p==1,:);   
plot3(temp(:,1),temp(:,2),temp(:,3),'.r');
hold on;
temp = v(p==2,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.b');
temp = v(p==3,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.g');
% 5th
temp = sort(real(diag(eig_valrw2)));
v = zeros(1500,k);
for i = 1:k
    v(:,i) = eig_vecrw2(:,real(diag(eig_valrw2))==temp(i));
end
rng(2);
[p, c] = kmeans(v,k);
subplot(2,3,5);

temp = v(p==1,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.r');
hold on;
temp = v(p==2,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.b');
temp = v(p==3,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.g');
% 6th
temp = sort(real(diag(eig_valsym2)));
v = zeros(1500,k);
for i = 1:k
    v(:,i) = eig_vecsym2(:,real(diag(eig_valsym2))==temp(i));
end
v = v ./ sqrt(sum(v.^2,2));
rng(2);
[p, c] = kmeans(v,k);
subplot(2,3,6);

temp = v(p==1,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.r');
hold on;
temp = v(p==2,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.b');
temp = v(p==3,:);
plot3(temp(:,1),temp(:,2),temp(:,3),'.g');
