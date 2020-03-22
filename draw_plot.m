function draw_plot(proportion_matrix,axes_handle,pop_size,number_of_generations)
% A program to plot the frequency of alleles in a certain population
% against the number of desired generations. It accepts a proportion
% matrix, an axis handle where the plot will be made and a desired number
% of generations.

%get the number of colums 
col = size(proportion_matrix,2);%

% set the default line color order
set(axes_handle,'defaultAxesColorOrder',[0 0 1;1 0 0;0 1 0;0 0 0;1 1 0;1 0 1;...
    0 1 1;0.85,0.325,0.098;0.301,0.745,0.933;0.7143,0.7143,0.7143;0.3333,1,0]) 

if col > 2 %if the proprtion matrix contains more than one allele clear the current axis then plot esle don't clear the axis
cla(axes_handle)% clear contents in the existing axis
    for allele = 1:col-1
        plot(axes_handle,proportion_matrix(:,1),proportion_matrix(:,allele+1))
        hold(axes_handle,'on')
    end
else
    for allele = 1:col-1
        plot(axes_handle,proportion_matrix(:,1),proportion_matrix(:,allele+1),...
            'Color','b')
        hold(axes_handle,'on')
    end
end
% edit axis and line properties
set(axes_handle,'ylim',[0 1],'xlim',[0 number_of_generations-1],'LineWidth',1)% set axes x and y limits and line width
line_handles = get(axes_handle,'children'); %get the handles for the lines
set(line_handles,'LineWidth',0.9)% set the thickness of the lines
xlabel(axes_handle,'Generation number','fontweight','bold')
ylabel(axes_handle,'Allele Frequency','fontweight','bold')
title(axes_handle,['Population Size =  ',num2str(pop_size)])
hold off
end
