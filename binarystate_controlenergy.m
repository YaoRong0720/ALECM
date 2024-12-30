% Credits: Authored by Rong yao in "Driving brain state transitions via Adaptive Local Energy Control Model"
%
% FUNCTION: 
%         compute control energy for each node in state transition.
%
% Only the adjacency matrix is required 
clc;
clear;
% Load SC_cell
load('SC_cell.mat'); % SC_cell is assumed to be in the same directory
SZ_SC = SC_cell{3}; % Structural connectivity for SZ

% Initialize result cell to store energy outputs
result_energy = cell(1, numel(fieldnames(SZ_SC)));

%% estimate 0 to system activation transitions
n = 246; % Number of brain regions
% time horizon and rho
T = 3;
rho = 1;
% target regions set to desired activation
xt = 1;
S = eye(n); % will be set to constrain the target


%from init to target
for i = 1:numel(fieldnames(SZ_SC))  %init_signals

    SC_name = sprintf("SZ_sub%d_SC",i);
    SC = getfield(SZ_SC, SC_name);   % adjacency matrix
    norm_SC = max_min_normalization(SC);
    
    xc = eye(n);% control matrix
    x0 = zeros(n,1);
    xf = ones(n,1);

    % xt:1001*246 state signals; Ut:60*1001 control signals; 
    % node_energy:1*246 every nodes energy; nr:1*1 errors
    [xt,Ut,node_energy,nr] = OCE_sim_bold(norm_SC, T, xc, rho, x0, xf, S); 
    sum_energy = sum(node_energy,2); %  Activate the total energy of the whole brain
    
    % Store results in the result_energy cell
    result_energy{i}.sum_energy = sum_energy; % Save total energy
end

% Save results to the same directory as SC_cell and BOLD_cell
save('binarystate_energy.mat', 'result_energy');

