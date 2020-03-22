function[proportion]= calculate_proportion(pop_size,population_matrix,number_of_alleles)
% A program to generate the frequencies or proportion of a certain number
% of alleles. It accepts a population size, a population matrix and number
% of alleles as input arguements and returns a proportion of alleles as its output
% arguement.

[row,~] = size(population_matrix);% get the number of rows in population matrix

%preallocation for speed
proportion = zeros(row,number_of_alleles);

if isvector(population_matrix) == 1%check if the population matrix is a vector or matrix to determine the calculation method 
    for allele = 1:number_of_alleles
        proportion(:,allele) = (sum(population_matrix==allele)./pop_size);
    end
else
    for allele = 1:number_of_alleles
        proportion(:,allele) = (sum((population_matrix==allele),2)./pop_size);
    end
end
end