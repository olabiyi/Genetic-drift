function [new_population] = genPop(number_of_generations,new_generation_size,initial_pop,tag_name)
% A program to generate a new random population from an initial population
% and a generation size.
%it accepts the desired number of generations, the new population size, the
%initial population and a tag name to the run or go button handle as input
%arguements and returns a new population as an output arguement.

%preallocating for memory and speed
new_population = zeros(number_of_generations-1,new_generation_size);

%generation 1
new_population(1,:) = datasample(initial_pop,new_generation_size);

%Get the user data of tag name 
run_handle = findobj('Tag',tag_name);
userdata = get(run_handle,'UserData');

%loop to generate a new population
for current_generation = 2:number_of_generations-1
    switch userdata
        case 1
            userdata = get(run_handle,'UserData');
            new_population(current_generation,:) = datasample((new_population(current_generation-1,:)),new_generation_size);
            pause(1E-323);%pause to make a decision
        case 0
            if strcmp(tag_name,'run') == 0 %compare the tag name string with run string
                new_population = [];
                return
            else
                msgbox('User stopped the program','Warning','warn')
                new_population =[];
                return
            end
    end
end
end