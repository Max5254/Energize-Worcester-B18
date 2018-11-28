function [data] = getQuestionData(dataIn,keyData,question)
%GETQUESTIONDATA gets required data for a specific question
%% determines type of question to get responses 
if(ismember(question, dataIn.Properties.VariableNames))
    %% pick one questions
    responses = dataIn.(question)(~isnan(dataIn.(question)));
    numResponses = length(responses);
elseif(ismember([question '_1'], dataIn.Properties.VariableNames)) 
    %% pick all that apply qustions
    numResponses = length(dataIn.([question '_1']));
    subscript = 1;
    responses = [];
    % loop through each subscript adding that number of responses to the
    % master list for each check box
    % ie. if 10 people answered yes to option 2, 10x 2's will be generated
    while(ismember(sprintf('%s_%d',question,subscript), dataIn.Properties.VariableNames))
        numYes = sum(dataIn.(sprintf('%s_%d',question,subscript)));
        responses = [responses ; ones(numYes,1)*subscript];
        subscript = subscript + 1;
    end
else
    %% unknown format for question
    error(['invalid field name ' question]);
end

%% catagorize and tabulate data 
cat = categorical(responses);
table = tabulate(responses);
key = keyData.(question).data;

%% Generate output
data = struct;
data.title = keyData.(question).title;
data.responses = responses;
data.numResponses = numResponses;
data.cat = cat;
data.table = table;
data.key = key;
data.labels = key(table(:,1),2);
end

