function [fixation_generation] = find_fixation_generation(proportion_matrix,number_of_generations)
%A program to the find the generation when the alleles in a population
%became fixed. It accepts a proportion matrix and a number of generations
%as input arguements and returns a fixation generation as its ouput.

% find the generations when alleles became fixed
logical_proportion_matrix = proportion_matrix(:,2:end) == 1;
[gen_row,~] = find(logical_proportion_matrix);


check = isempty(gen_row);
if check == 1
    %specifying the highest possile average based on the number of
    %generations for plotting the bar graph of mean fixation time against
    %population size
    fixation_generation = number_of_generations+5;
else
    % The generation when fixation started is the first element in gen_row
fixation_generation = gen_row(1);
end
end