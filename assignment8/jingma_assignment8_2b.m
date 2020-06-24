% jingma
% 04/21/2018

k = 5;
[eig_vec,eig_val] = eigs(Lsym, k, 'smallestreal');
v = eig_vec ./ sqrt(sum(eig_vec.^2,2));
rng(2);
[p, c] = kmeans(v,k);

figure;
colors = 'rbgkc';
for i = 1:5
    plot(Data.longitude(p==i),Data.latitude(p==i),strcat('.',colors(i)));
    hold on;
end
plot_google_map;
