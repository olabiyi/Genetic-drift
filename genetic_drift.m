function [proportion_matrix]= genetic_drift(pop_size,number_of_generations,number_of_alleles,tag_name)

%A program to simulate genetic drift of a fictional organism in which a
%trait such as skin color is controlled by only one gene with as many
%alleles as specified. It accepts an initial population size, number of
%generations, number of alleles and a tag name as input arguements. In this
%model the organism reproduces asexuallly, there is no selection, crossing
%over, no overlapping generations and a constant population size.

%generating an initial population of population size
initial_population = randi(number_of_alleles,1,pop_size);

%calculate the proportion of each allele in the initial population
initial_proportion= calculate_proportion(pop_size,initial_population,number_of_alleles);

% randomly generate a reduced population due to bottle neck or founders effect
prop_lost = rand(); % generate a random proportion of the initial population lost
new_generation_size = round(pop_size - (pop_size*prop_lost));
new_population = genPop(number_of_generations,new_generation_size,initial_population,tag_name);

if isempty(new_population) == 1%if the new population is empty then exit the program else generate a proportion matrix
    proportion_matrix =[];
    return
else
final_proportion= calculate_proportion(new_generation_size,new_population,number_of_alleles);
proportion_matrix = genPropMat(number_of_alleles,number_of_generations,...
    initial_proportion,final_proportion);
end

end
