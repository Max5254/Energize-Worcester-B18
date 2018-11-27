%% Energize Worcester Student Survey
%  Max Westwater
%
%  Reads in response data from survey Excel sheet
%
clearvars; close all; clc;

%% Constants
nf = 0; % figure number for fig array, incremented before each figure
f = defaultFonts;
fileName = '11.16.18/results-for-energize-worc-2018-11-16-1046.csv';
keyFileName = '11.16.18/results-for-energize-worc-2018-11-16-1042-key.xlsx';

%% Read in file
data = importStudentSurvey(fileName);
key = readKey(keyFileName);

%% Find users who actually answered Q17-23
%  Those who picked all the same response are thrown out 
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


%% Q2 - Gender
Males = data(1 == data.Q2,:);
Females = data(2 == data.Q2,:);

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

%% Q17-23
nf = nf+1;
figs(nf) = PieChart(data,key,'Q17','Mobile Control');
nf = nf+1;
figs(nf) = PieChart(data,key,'Q18','Weather Compensation');
nf = nf+1;
figs(nf) = PieChart(data,key,'Q19','Home Presence Detection');
nf = nf+1;
figs(nf) = PieChart(data,key,'Q20','Fault Codes');
nf = nf+1;
figs(nf) = PieChart(data,key,'Q21','Timed Schedules');
nf = nf+1;
figs(nf) = PieChart(data,key,'Q22','Energy History Graphs');
nf = nf+1;
figs(nf) = PieChart(data,key,'Q23','Individual Room Control');

%% Summary of weather question data
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
q = getQuestionData(data,key,'Q10');
bigPie(q.cat,q.labels);
title('What is done if you''re too warm.','fontsize',f.title);
plotTextbox(sprintf('N = %d',q.numResponses));

%% Q28
nf = nf+1;
figs(nf) = figure;
q = getQuestionData(data,key,'Q10');
bigPie(q.cat,q.labels);
title('You and your housemate(s) have similar schedules.','fontsize',f.title);
plotTextbox(sprintf('N = %d',q.numResponses));
