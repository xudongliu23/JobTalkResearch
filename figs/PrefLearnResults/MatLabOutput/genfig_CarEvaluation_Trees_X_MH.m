addpath ~/export_fig/

%% plot CarEvaluation_Trees_X_MH.pdf
fName1 =  'CarEvaluation_Trees.csv';
f1ID = fopen(fName1);
C_title = textscan(f1ID, '%s', 11, 'Delimiter',',');
C_data = textscan(f1ID,'%d %f %f %f %f %f %f %f %f %f %f', 'Delimiter',',');
fclose(f1ID);
% celldisp(C_title)
% celldisp(C_data)

plot(C_data{1}, C_data{2}, '-r', 'MarkerSize', 6, 'LineWidth', 2)
hold on;
plot(C_data{1}, C_data{3}, '--r', 'MarkerSize', 6, 'LineWidth', 2)
plot(C_data{1}, C_data{4}, '-b', 'MarkerSize', 6, 'LineWidth', 2)
plot(C_data{1}, C_data{5}, '--b', 'MarkerSize', 6, 'LineWidth', 2)
hold off;

xlabel('Sample size')
ylabel('Accuracy%')
xlim([1 250])
ylim([0.4 1])

hleg1 = legend(C_title{1}{[2,3,4,5]});
set(hleg1, 'Location','SouthEast')

%% export the figure to pdf
% exportfigure(gcf, '~/test.pdf', [4 3], 300)
export_fig ./CarEvaluation_Trees_X_MH.pdf -transparent 
