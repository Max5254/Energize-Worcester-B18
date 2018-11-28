function [cellOut] = questions2csv(dataIn,keyData,questions,fileName)
%QUESTIONS2CSV Summary of this function goes here
numQuestions = length(questions);
% cellOut = cell(1,3);
for i = 1:numQuestions
    currQ = sprintf('Q%d',questions{i});
    d = getQuestionData(dataIn,keyData,currQ);
    qCell = cell(size(d.labels,1)+1,3);
    qCell(1,1:2) = {currQ, d.title};
    qCell(2:end,2) = d.labels;
    qCell(2:end,3) = num2cell(d.table(:,2));
    if(i == 1)
        cellOut = qCell;
    else
        cellOut = [cellOut ; qCell];
    end
end
cell2csv(['out/' fileName],cellOut,';')
% data.out = [key(:,2) num2cell(table(:,2))];
end

