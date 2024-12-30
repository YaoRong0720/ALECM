% The original data is data, normalized for each row, and the data after normalization is normalized_data
function [ normalized_data ] = Normalization(data)
% Credits: Authored by Rong yao
% in "Driving brain state transitions via Adaptive Local Energy Control Model"
% Function: normalization of the adjacency matrix
% Input: data: N*N adjacency matrix
% Output: normalized_data: N*N Normalized adjacency matrix

%% 0-1 normalization 
% % 'data' with 246 rows
% % Get the number of rows and columns in the matrix
% [num_rows, num_cols] = size(data);
% 
% % Create a matrix of the same size as 'data' to store the normalized data
% normalized_data = zeros(num_rows, num_cols);
% 
% % Normalize each row from 0 to 1
% for i = 1:num_rows
%     row_data = data(i, :);  % Get the current row data
%     min_val = min(row_data);  % Compute the minimum value of the current row
%     max_val = max(row_data);  % Compute the maximum value of the current row
%     normalized_data(i, :) = (row_data - min_val) / (max_val - min_val);  % Normalize the current row data
% end
% 
% 
%% Z-Score normalization 
% % Z-Score normalize each row
% for i = 1:num_rows
%     row_data = data(i, :);  % Get the current row data
%     mean_val = mean(row_data);  % Compute the mean of the current row
%     std_val = std(row_data);  % Compute the standard deviation of the current row
%     normalized_data(i, :) = (row_data - mean_val) / std_val;  % Z-Score normalize the current row data
% end

%% Maximum and minimum normalization for the whole matrix
% min_val = min(data);  % Compute the minimum value 
% max_val = max(data);  % Compute the maximum value 
% normalized_data = (data - min_val) / (max_val - min_val);  % Normalize the current row data



%% Perform zscore normalization by finding the mean variance of the entire matrix
mean_val = mean(data(:));  % Compute the mean of
std_val = std(data(:));  % Compute the standard deviation
normalized_data = (data - mean_val) / std_val;  % Z-Score normalize the current row data
end
