function [binary_matrix] = max_min_normalization(fiber_matrix)
% Credits: Authored by Rong yao
% in "Driving brain state transitions via Adaptive Local Energy Control Model"
% Function: Max-min normalization of the adjacency matrix
% Input: fiber_matrix: N*N adjacency matrix
% Output: binary_matrix: N*N Normalized adjacency matrix

maxdata=max(fiber_matrix);
mindata=min(fiber_matrix);
n = size(fiber_matrix,1);
binary_matrix=zeros(n);
a=maxdata-mindata;
for i=1:n
    for j=1:n
        binary_matrix(i,j)=(fiber_matrix(i,j)-mindata)/a;
    end
end

end



