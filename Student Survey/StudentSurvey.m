%% Energize Worcester Student Survey
%  Max Westwater
%
%  Reads in response data from survey Excel sheet
%
clearvars; close all; clc;

%% Constants
fileName = '11.16.18/results-for-energize-worc-2018-11-16-1046.csv';


%% Read in file
data = importStudentSurvey(fileName);
removeRows = [];
for i = 1:size(data,1)
    d = data(i,:);
    q = table2array(d(:,27:33));
    u = unique(q);
    if(length(u)<2)
        removeRows = [removeRows ; i];
    end
end

uniqueData = data;
uniqueData(removeRows,:) = [];


%% Filter data based on parameters
Males = data(1 == data.Q2,:);
Females = data(2 == data.Q2,:);


nf = 0;
nf = nf+1;
figs(nf) = figure;
QCompleted = data.('Q2')(~isnan(data.('Q2')));
tbl = categorical(QCompleted);
labels = {'Male','Female'};
p = pie(tbl,{},labels);
for i = 1:length(p)
   if(isprop(p(i),'FontSize'))
       p(i).FontSize = 20;
   end
end
title({'Gender'},'fontsize',50);
% legend('Male','Female','Other');
plotTextbox(sprintf('N = %d',length(QCompleted)));
disp(1);

%% Q17-23
nf = nf+1;
figs(nf) = PieChart(data,'Q17','Mobile Control');
nf = nf+1;
figs(nf) = PieChart(data,'Q18','Weather Compensation');
nf = nf+1;
figs(nf) = PieChart(data,'Q19','Home Presence Detection');
nf = nf+1;
figs(nf) = PieChart(data,'Q20','Fault Codes');
nf = nf+1;
figs(nf) = PieChart(data,'Q21','Timed Schedules');
nf = nf+1;
figs(nf) = PieChart(data,'Q22','Energy History Graphs');
nf = nf+1;
figs(nf) = PieChart(data,'Q23','Individual Room Control');

%% Summary of weather question data
% https://github.com/MelanieIStefan/matlikert
nf = nf+1;
figs(nf) = figure;
firstSmart = 17-1;
numSmart = 7;
ratings = zeros(numSmart,5);
for i = 1:numSmart
    q = sprintf('Q%d',i+firstSmart);
    QCompleted = data.(q)(~isnan(data.(q)));
    tbl = flipud(tabulate(QCompleted));
    ratings(i,:) = tbl(:,2)';
end
allLabels = fliplr({'Extremely','Very','Moderately','Slightly','Not at all'});

allGroups={'Mobile Control',
    'Weather Compensation',
    'Home Presence Detection',
    'Fault Codes',
    'Timed Schedules',
    'Energy History Graphs',
    'Individual Room Control'};
question=['How interested are students in the following?'];
likert(allLabels,allGroups,ratings,question)
plotTextbox(sprintf('N = %d',length(QCompleted)));

%% Q10
nf = nf+1;
figs(nf) = figure;
QCompleted = data.('Q10')(~isnan(data.('Q10')));
labels = {'Adjust the main thermostat',
          'Adjust my individual radiators TRV',
          'Open my window',
          'Take off some layers of clothing',
          'Nothing'};
tbl = categorical(QCompleted);
p = pie(tbl,{},labels);
for i = 1:length(p)
   if(isprop(p(i),'FontSize'))
       p(i).FontSize = 20;
   end
end
title('What is done if you''re too warm.','fontsize',30);
plotTextbox(sprintf('N = %d',length(QCompleted)));

%% Q28
nf = nf+1;
figs(nf) = figure;
QCompleted = data.('Q28')(~isnan(data.('Q28')));
labels = {'Strongly agree',
'Moderately agree',
'Neutral',
'Moderately disagree',
'Strongly disagree'};
tbl = categorical(QCompleted);
p = pie(tbl,{},labels);
for i = 1:length(p)
   if(isprop(p(i),'FontSize'))
       p(i).FontSize = 20;
   end
end
title('You and your housemate(s) have similar schedules.','fontsize',30);
plotTextbox(sprintf('N = %d',length(QCompleted)));