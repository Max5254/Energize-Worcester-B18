function [p] = bigPie(cat,labels)
%BIGPIE Summary of this function goes here
f = defaultFonts();
p = pie(cat,{},labels);
for i = 1:length(p)
   if(isprop(p(i),'FontSize'))
       p(i).FontSize = f.labels;
   end
end
end

