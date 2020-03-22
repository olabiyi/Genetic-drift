function [avg_fix_vec,standard_error] = fixationStat(pop_size_vec,number_of_generations,...
    number_of_repetitions,number_of_alleles,tag_name)
% A program to calculate average fixation times and their standard errors
% for defined population sizes. It accepts a vector of population sizes, a
% number of generations, number of repetitions, number of alleles and a tag
% name as input arguements. It generates a vector of average fixation times
% and their standard erros as output arguements.

%preallocation for memory and speed
fixation = cell(1,length(pop_size_vec));
avg_fix_vec = zeros(1,length(pop_size_vec));
standard_error = zeros(1,length(pop_size_vec));

% get the handle of the go push button and it's userdata
go_handle = findobj('Tag',tag_name);
userdata = get(go_handle,'UserData');

%Nested loop to find the fixation generations and calculate their average and standard errors 
for pop = 1:length(pop_size_vec)

    for repetitions = 1:number_of_repetitions
        
        switch userdata
            case 1
                userdata = get(go_handle,'UserData');% get the value of the go button userdata
                proportion_matrix =genetic_drift(pop_size_vec(pop),number_of_generations,number_of_alleles,tag_name);% calculate and get the proportion matrix
                fixation_generation = find_fixation_generation(proportion_matrix,number_of_generations);%find the first generation when fixation occured 
                fixation{pop}(repetitions) = fixation_generation;%save the fixation generations in a vector within a cell called fixation
                pause(1E-323);%pause simulation to check condition
            case 0 % if userdata is zero as a result of pressing the stop button
                avg_fix_vec = [];
                standard_error =[];
                msgbox('Fixation simulation stopped','Warning','warn')
                return
        end
    end

        avg_fix_vec(pop) = mean(fixation{pop});% the average fixation is the average of the elements of the vector within cell pop
        standard_error(pop)= (std(fixation{pop}))./sqrt(number_of_repetitions);% the standard error is the standard error of the average of the elements of the vector within cell pop
end
end
