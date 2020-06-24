% jingma
% 04/21/2018

clear;
Data = load('BostonListing.mat');
% (i)
sigma = 0.01;
n = 2558;
W = zeros(n,n);
for i = 1:n
    for j = i:n
        temp = exp(- ((Data.longitude(i)-Data.longitude(j)).^2 + (Data.latitude(i)-Data.latitude(j)).^2) / (2*sigma^2));
        W(i,j) = temp;
        W(j,i) = temp;
    end
end
D = diag(W * ones(n,1));
L = D - W;
Lsym = diag(diag(D).^(-0.5)) * L * diag(diag(D).^(-0.5));

purity = zeros(25,1);
for k = 1:25
    [eig_vec,eig_val] = eigs(Lsym, k, 'smallestreal');
    v = eig_vec ./ sqrt(sum(eig_vec.^2,2));
    rng(2);
    [p, c] = kmeans(v,k);
    purity(k) = comp_purity(p,Data.neighbourhood,n);
end

figure;
plot(1:25,purity,'-o','LineWidth',2);
xlabel('k');
ylabel('purity');

%%%%%%%%%% function %%%%%%%%%%
function purity = comp_purity(yhat,y,n)

k = length(unique(yhat));
labels = unique(categorical(y));
m = length(labels);

purity = 0;
for i = 1:k
    nij = zeros(m,1);
    temp1 = (yhat==i);
    for j = 1:m
        temp2 = (y==labels(j));
        nij(j) = sum((temp1+temp2)==2);
    end
    purity = purity + max(nij);
end

purity = purity/n;

end
