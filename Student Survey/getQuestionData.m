function [data] = getQuestionData(data,keyData,question)
%GETQUESTIONDATA gets required data for a specific question 
responses = data.(question)(~isnan(data.(question)));
numResponses = length(responses);
cat = categorical(responses);
table = tabulate(responses);
key = keyData.(question);

data = struct;
data.responses = responses;
data.numResponses = numResponses;
data.cat = cat;
data.table = table;
data.key = key;
data.labels = key(:,2);
end

