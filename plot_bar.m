function [] = plot_bar(wtc)

global fontsize;

b = bar(wtc);
b.FaceColor = 'flat';
for k = 1:4
    if k == 1 || k == 3
        b.CData(k,:) = [0.7, 0, 0.7];
    elseif k == 2 || k == 4
        b.CData(k,:) = [1, 1, 0];
    end
end
set(gca,'FontSize', fontsize);
title("Wall clock times");
text(1:length(wtc),wtc,num2str(wtc'),'vert','bottom','horiz','center', 'FontSize', fontsize); 
str={'Grid r = 1 - global'; 'Grid r = 1 - local'; 'Grid r = 0.1 - global'; 'Grid r = 0.1 - local'};
set(gca, 'XTickLabel',str, 'XTick',1:numel(str));
ylabel("Wall clock time");
end

