function fig = PieChart(data,key,question,feature)
%%
fig = figure;
f = defaultFonts;
q = getQuestionData(data,key,question);
bigPie(q.cat,q.labels);
title({'Level of interest in given feature',feature},'fontsize',f.title);
plotTextbox(sprintf('N = %d',q.numResponses));
end