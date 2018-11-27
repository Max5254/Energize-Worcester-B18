function [questions,data] = readKey(fileName)
%% READKEY reads in the key file and outputs in a format that scripts can use
T = readtable(fileName,'ReadVariableNames',false);
data = table2cell(T);
questions = struct;
for i = 1:size(data,1)
    d = data{i,1};
    if(d(1) == 'Q')
        curQNum = d;
        curQTitle = data{i,2};
        questions.(d) = struct;
        questions.(d).data = [];
        questions.(curQNum).title = curQTitle;
    else
        questions.(curQNum).data = [questions.(curQNum).data ; {data{i,:}}];
    end
end
end

