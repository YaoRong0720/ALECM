function [Values] = Average_controllability( A )
% Credits: Authored by Rong yao in "Driving brain state transitions via Adaptive Local Energy Control Model"
%
% FUNCTION: 
%         compute average controllability for each node.
% INPUT: 
%         A is the N x N input ajaciency matrix
% OUTPUT: 
%         N x 1 vector of average controllability values
       

A = A/(1+eigs(A,1));
SeriesSum = dlyap(A,eye(size(A,1))); %%Solve discrete Lyapunov equations.

Values = diag(SeriesSum);
end



