function [proportion_matrix] = genPropMat(number_of_alleles,number_of_generations,...
    initial_prop,final_proportion)
%A program to generate a proportion matrix of each allele in a given
%population. It accepts a number of alleles, number of generations, an
%initial proportion of alleles in generation zero and a final proportion of
%alleles for generation 1 to the end as input arguements and generates a
%proportion matrix as its output arguement.

%Preallocation for memory and speed
proportion_matrix= zeros(number_of_generations,number_of_alleles+1);%proportion matrix
generations = (0:number_of_generations-1)';%generation vector

% Assigning positions 
proportion_matrix(:,1) = generations;%defining the position of the generation vector
proportion_matrix(1,2:number_of_alleles+1) = initial_prop;%assigning the initial frequencies

%Loop to concatenate the generation vector, intial and final frequencies 
for col = 2:number_of_alleles+1
proportion_matrix(2:end,col)= final_proportion(:,col-1);%defining the position of final allele frequency matrix
end
end