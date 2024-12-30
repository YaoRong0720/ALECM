% Credits: Authored by Rong yao
% in "Driving brain state transitions via Adaptive Local Energy Control Model"
% Needs an adjacency matrix as well as initial state signals, target state signals
% The start time and end time of the status signal need to be set.
clc;
clear;

% Load SC_cell and BOLD_cell data
load('SC_cell.mat'); % SC_cell is assumed to be in the same directory
load('BOLD_cell.mat'); % BOLD_cell is assumed to be in the same directory

% Extract SC data
BD_SC = SC_cell{1}; % Strctural connectivity for BD
HC_SC = SC_cell{2}; % Structural connectivity for HC
SZ_SC = SC_cell{3}; % Structural connectivity for SZ

% Extract BOLD signal data
BD_BOLD = BOLD_cell{1}; % BOLD signals for BD
HC_BOLD = BOLD_cell{2}; % BOLD signals for HC
SZ_BOLD = BOLD_cell{3}; % BOLD signals for SZ

% Initialize result cell to store energy outputs
result_energy = cell(1, numel(fieldnames(SZ_BOLD)));

%% Parameter settings
n = 246; % Number of brain regions
T = 3; % Time horizon for the transition
rho = 1; % Regularization parameter for control
xt = 1; % Target activation state
S = eye(n); % Target constraint matrix

% Compute the average BOLD signal using HC_BOLD as the target
sum_signal = zeros(246, 142);
for num = 1:numel(fieldnames(SZ_BOLD))
    name = sprintf("SZ_sub%d_BOLD",num);
    sum_signal = sum_signal + getfield(SZ_BOLD, name)';
end
aver_signal = sum_signal / numel(HC_BOLD);

% Normalize the target signal
xf = Normalization(aver_signal); % z-score normalization of the target signal

% Process each subject in SZ_BOLD
for i = 1:numel(fieldnames(SZ_BOLD))
    % Load the initial BOLD signal for the subject
    signal_name = sprintf("SZ_sub%d_BOLD",i);
    init_signal = getfield(SZ_BOLD, signal_name)';
    x0 = Normalization(init_signal); % z-score normalization of the initial signal

    % Define the time points of interest
    starttime = 1;
    endtime = 142;
    timepoints = endtime - starttime + 1;
    x0 = x0(:, starttime:endtime);
    xf = xf(:, starttime:endtime);

    % Load the structural connectivity matrix for SZ
    SC_name = sprintf("SZ_sub%d_SC",i);
    SC = getfield(SZ_SC, SC_name);  % Use SZ_SC for structural connectivity
    norm_SC = max_min_normalization(SC); % Normalize SC values between 0 and 1

    % Define the control matrix
    xc = eye(n);

    % Compute energy using the MultiPoints_OCE_sim_bold function
    [Ut, node_energy] = MutiPoints_OCE_sim_bold(norm_SC, T, xc, rho, x0, xf, S, timepoints);
    sum_energy = sum(node_energy, 2); % Total energy at each time point
    aver_energy = mean(sum_energy, 2); % Average energy across time points

    % Store results in the result_energy cell
    result_energy{i}.sum_energy = sum_energy; % Save total energy
    result_energy{i}.aver_energy = aver_energy; % Save average energy
    result_energy{i}.subject = sprintf('Sub%03d', i); % Save subject identifier
end

% Save results to the same directory as SC_cell and BOLD_cell
save('Homo_state_energy.mat', 'result_energy');
