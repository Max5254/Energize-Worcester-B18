function [cellOut] = questions2csv(dataIn,keyData,questions,fileName)
%QUESTIONS2CSV Summary of this function goes here
numQuestions = length(questions);
% cellOut = cell(1,3);
for i = 1:numQuestions
    q = questions{i};
    if(rem(q,1)==0)
        %% normal questions w/o sub part
        currQ = sprintf('Q%d',q);
    else
        %% questions with part a/b/etc....
        %  10.1 represents 10_a
        dec = rem(q,1); % find decimal part of number
        int = q-dec;    % find int part of number
        currQ = sprintf('Q%d_%c',int,char(dec+97)); % 97 is offset in ascii to a
    end
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

