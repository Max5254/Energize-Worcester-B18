function [data] = getQuestionData(dataIn,keyData,question)
%GETQUESTIONDATA gets required data for a specific question 
responses = dataIn.(question)(~isnan(dataIn.(question)));
numResponses = length(responses);
cat = categorical(responses);
table = tabulate(responses);
key = keyData.(question).data;

data = struct;
data.title = keyData.(question).title;
data.responses = responses;
data.numResponses = numResponses;
data.cat = cat;
data.table = table;
data.key = key;
data.labels = key(table(:,1),2);
end

