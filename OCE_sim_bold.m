
function [X_opt_subset, ter_U_opt, E, nr] = OCE_sim_bold(W, T, xc, rho, x0, xf, S)
% Credits: Authored by Rong yao 
% in "Driving brain state transitions via Adaptive Local Energy Control Model"
% Function: Compute control signals and energy for brain state transitions
%           at single time points
% inputs: 
%       W: Adjacency matrix N*N
%       T: Time scale, default is 3
%       xc: Control matrix, which determines which brain regions are
%           controlled. N*N
%       rho: Weight parameter, which determines the relative weights of 
%           trajectory costs and control costs, default is 1
%       x0: Initial state N*1
%       xf: Target state N*1
%       S: Constriant matrix,which determines which brain regions' activity
%           is restricted from deviating from the target state N*N
%
% outputs:
%       Ut: Control signals N*1001
%       node_energy: Control energy N*1

% energy estimate
[X_opt, U_opt, n_err] = opt_eng_cont(W, T, xc, x0, xf, rho, S, 1);
ter_U_opt = U_opt';
n = size(W,2);
X_opt_subset = X_opt(:,1:n);


E = sum(U_opt.^2 * 0.001); % sum energy while discount on target numbers, 1000 steps
nr = n_err;
end