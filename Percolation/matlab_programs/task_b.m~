%Program for the third project in the subject Fys-4460
%Inordered systems and Percolation at UiO
% 01.04.2015    Gullik Vetvik Killie


%   run the program percolation.m first to generate the needed data in the
%   workspace. P and prob


%Task (b) Since P is proportional to |p-p_c|^beta we will plot a log log plot of P and p-p_c

p_c = 0.59275;

%Count the probabilities above the p_c
nProb = 0;
for i = 1:length(prob)
    if(prob(i) >= p_c)
        nProb = nProb + 1;
    end
end

%Setting up matrix to store results in
loglogMatrix = zeros(nProb,2);
skipProb = nProb - length(prob);

for i = 1:nProb
    loglogMatrix(i,1) = prob(i);
end

loglogMatrix