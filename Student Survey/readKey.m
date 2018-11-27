function [questions,data] = readKey(fileName)
%% READKEY reads in the key file and outputs in a format that scripts can use
T = readtable(fileName,'ReadVariableNames',false);
data = table2cell(T);
questions = struct;
for i = 1:size(data,1)
    d = data{i,1};
    if(d(1) == 'Q')
        curQ = d;
        questions.(d) = [];
    else
        questions.(curQ) = [questions.(curQ) ; {data{i,:}}];
    end
end
end

