% jingma
% 03/20/2018

% a 2

n = length(data.Dates);
features_short = zeros(n,6);
set_category = unique(data.Category);

for i = 1:n
    temp_hour = hour_extract(data.Dates(i));
    features_short(i,1) = temp_hour;
    temp_dayofweek = dayofweek_extract(data.DayOfWeek(i));
    features_short(i,2) = temp_dayofweek;
    temp_district = district_extract(data.PdDistrict(i));
    features_short(i,3) = temp_district;
    temp_category = category_extract(data.Category(i),set_category);
    features_short(i,4) = temp_category;
end

figure;
subplot(2,2,1);
histogram(features_short(:,1),'Normalization','pdf');
xlabel('hour');
subplot(2,2,2);
histogram(features_short(:,2),'Normalization','pdf');
xticks(0:6);
xticklabels({'Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'});
xtickangle(45);
subplot(2,2,3);
histogram(features_short(:,3),'Normalization','pdf');
xticks(1:10);
xticklabels({'BAYVIEW','CENTRAL','INGLESIDE','MISSION','NORTHERN','PARK','RICHMOND',
    'SOUTHERN','TARAVAL','TENDERLOIN'});
xtickangle(45);
figure;
histogram(features_short(:,4),'Normalization','pdf');
xticks(1:length(set_category));
xticklabels(set_category);
xtickangle(45);

% a 3

likely_3 = zeros(length(set_category),1);
for i = 1:length(set_category)
    temp = features_short(features_short(:,4)==i,1);
    likely_3(i,1) = mode(temp);
end

% a 4

likely_4 = {};
for i = 1:10
    temp = features_short(features_short(:,3)==i,4);
    temp = set_category(mode(temp));
    likely_4{end+1} = temp{1};
end

% a 5

features_short(:,5) = data.X;
features_short(:,6) = data.Y;

figure;
temp = features_short(features_short(:,4)==8,:);
plot(temp(:,5),temp(:,6),'.r','MarkerSize',5);
xlim([-122.55,-122.35]);
ylim([37.7,37.8]);
plot_google_map;
figure;
temp = features_short(features_short(:,4)==17,:);
plot(temp(:,5),temp(:,6),'.b','MarkerSize',5);
xlim([-122.55,-122.35]);
ylim([37.7,37.8]);
plot_google_map;
figure;
temp = features_short(features_short(:,4)==26,:);
plot(temp(:,5),temp(:,6),'.k','MarkerSize',5);
xlim([-122.55,-122.35]);
ylim([37.7,37.8]);
plot_google_map;

%%%%%%%%%%%%%%%%%%%%%% functions %%%%%%%%%%%%%%%%%%%%%%%%%%
function f = hour_extract(date)
    f = split(date,' ');
    f = f(2);
    f = split(f,':');
    f = f(1);
    f = str2double(f);
end

function f = dayofweek_extract(dayofweek)
    if strcmp(dayofweek,'Sunday')
        f = 0;
    elseif strcmp(dayofweek,'Monday')
        f = 1;
    elseif strcmp(dayofweek,'Tuesday')
        f = 2;
    elseif strcmp(dayofweek,'Wednesday')
        f = 3;
    elseif strcmp(dayofweek,'Thursday')
        f = 4;
    elseif strcmp(dayofweek,'Friday')
        f = 5;
    elseif strcmp(dayofweek,'Saturday')
        f = 6;
    end
end

function f = district_extract(district)
    if strcmp(district,'BAYVIEW')
        f = 1;
    elseif strcmp(district,'CENTRAL')
        f = 2;
    elseif strcmp(district,'INGLESIDE')
        f = 3;
    elseif strcmp(district,'MISSION')
        f = 4;
    elseif strcmp(district,'NORTHERN')
        f = 5;
    elseif strcmp(district,'PARK')
        f = 6;
    elseif strcmp(district,'RICHMOND')
        f = 7;
    elseif strcmp(district,'SOUTHERN')
        f = 8;
    elseif strcmp(district,'TARAVAL')
        f = 9;
    elseif strcmp(district,'TENDERLOIN')
        f = 10;
    end
end

function f = category_extract(category,set_category)
    for i = 1:length(set_category)
        if strcmp(category,set_category(i))
            f = i;
            break;
        end
    end
end

