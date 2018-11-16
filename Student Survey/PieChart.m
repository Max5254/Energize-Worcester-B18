function fig = PieChart(data,question,feature)
%%
fig = figure;
QCompleted = data.(question)(~isnan(data.(question)));
tbl = categorical(QCompleted);
labels = {'Extremely','Very','Moderately','Slightly','Not at all'};
p = pie(tbl,{},labels);
for i = 1:length(p)
   if(isprop(p(i),'FontSize'))
       p(i).FontSize = 20;
   end
end
title({'Level of interest in given feature',feature},'fontsize',30);
plotTextbox(sprintf('N = %d',length(QCompleted)));
end