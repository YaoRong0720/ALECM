function [Ut,node_energy] = MutiPoints_OCE_sim_bold(W, T, xc, rho, x0, xf, S,timepoints)

% Credits: Authored by Rong yao 
% in "Driving brain state transitions via Adaptive Local Energy Control Model"
% Function: Compute control signals and energy for brain state transitions
%           at multiple time points
% inputs: 
%       W: Adjacency matrix N*N
%       T: Time scale, default is 3
%       xc: Control matrix, which determines which brain regions are
%           controlled. N*N
%       rho: Weight parameter, which determines the relative weights of 
%           trajectory costs and control costs, default is 1
%       x0: Initial state N*K
%       xf: Target state N*K
%       S: Constriant matrix,which determines which brain regions' activity
%           is restricted from deviating from the target state N*N
%       timepoints: Number of time points K
%
% outputs:
%       Ut: Control signals N*K*1001
%       node_energy: Control energy N*K

for k = 1:timepoints
    x01 = x0(:,k);
    xf1 = xf(:,k);
    [X_opt_subset,ter_U_opt,OCE_sys_60, nr] = OCE_sim_bold(W, T, xc, rho, x01, xf1, S);
    Ut(:,k,:) = ter_U_opt;
    node_energy(:,k) = OCE_sys_60;
end
