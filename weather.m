%% Energize Worcester Weather Data API Requests
%  Max Westwater
%
%  Pulls weather data from the Dark Sky API 
%  Documenation available here: https://darksky.net/dev/docs
%
clearvars; close all; clc;

%% Parameters to change
location = '52.196537, -2.243724'; % St. Johns Campus 
time = datetime('11/11/2017','format','MM/dd/uuuu');

%% Constant variables
baseUrl = 'https://api.darksky.net/forecast';
key = '34a8db7c4dce234375bd8845299a75f5';
unixTime = posixtime(time);
url = [baseUrl '/' key '/' location ',' num2str(unixTime)];
%% Get data
data = webread(url);

rawHourlyData = data.hourly.data;
numHours = length(rawHourlyData);
parameters = {'time','precipProbability','temperature','apparentTemperature','cloudCover'};
hourlyData = zeros(numHours,length(parameters));
for i = 1:numHours
    if(iscell(rawHourlyData)) % check what format the data was returned in 
        d = rawHourlyData{i};
    else
        d = rawHourlyData(i);
    end
    currentTime = datetime(d.time,'ConvertFrom','posixtime');
    hourlyData(i,1) = currentTime.Hour;
    for j = 2:length(parameters)
        hourlyData(i,j) = d.(parameters{j});
    end
end

%% Convert to table
T = array2table(hourlyData,'VariableNames',parameters)

%% Plot data
figure; 
hold on; grid on;
yyaxis left
plot(T.time, T.temperature)
plot(T.time, T.apparentTemperature)
ylabel('Temperature (F)');

yyaxis right
plot(T.time, T.precipProbability*100)
ylabel('Precipitation (%)');


legend('temperature','feels like','precipitation','Location','SW')

xlim([0 23]);
xlabel('Time (Hour)');


title(['Hourly Weather [' datestr(time) ']']);