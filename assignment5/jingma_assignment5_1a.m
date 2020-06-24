% jingma
% 03/18/2018

data = load('./data_SFcrime.mat');

n = length(data.Dates);
features = zeros(n,41);

for i=1:n
    temp_hour = hour_extract(data.Dates(i));
    features(i,temp_hour+1) = 1;
    temp_dayofweek = dayofweek_extract(data.DayOfWeek(i));
    features(i,temp_dayofweek+25) = 1;
    temp_district = district_extract(data.PdDistrict(i));
    features(i,temp_district+31) = 1;
end

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