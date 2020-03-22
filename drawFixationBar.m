function drawFixationBar(axes_handle,avg_fix_vec,standard_error,pop_size_vec)
% A program to plot a bar graph of mean fixation times after a certain number
% of generations of certain population sizes against the population sizes. It
% accepts an axis handle where the plot will be made,  the mean fixation
% vector, its standard error and a vector of population sizes as input
% arguements

%plot bar graph then set its proporties
bar(axes_handle,avg_fix_vec);
set(axes_handle,'XTickLabel',{num2str(pop_size_vec(1)),...
    num2str(pop_size_vec(2)),num2str(pop_size_vec(3)),num2str(pop_size_vec(4))})
title(axes_handle,'Fixation Time','fontsize', 14);
xlabel('Population Size','fontweight','bold')
ylabel('Mean fixation time','fontweight','bold')
hold on
%plot error bar with a line conneting the data points
errorbar(axes_handle,avg_fix_vec,standard_error)
hold off
end