function [ phi, phi_p, phi_t ] = modal_controllability(A, thresh, nor)
% Credits:
% @author JStiso
% modified by Rong yao 
% in "Driving brain state transitions via Adaptive Local Energy Control Model"
%
% Calculate persistent and transient modal controllability of each node.
% Intuitively, nodes with high persistent controllability will result in
% large perturbations to slow modes of the system when stimulated, and
% nodes with high transient controllability will result in large
% perturbations to fast modes of the system when stimulated
% Inputs:
% A         The NxN structural (NOT FUNCTIONAL) network adjacency matrix
% thresh    The thresh hold for calculating persistent and transient modal
%           controllability. For example, if thresh is .1, this will
%           use the 10% slowest modes for persistent controllability, and
%           the 10% fastest modes for transient controllability.

% Outputs:
% phi_p     Persistent controllability of the node (should be between 0 and
%           1)
% phi_t     Transient controllability (should be between 0 and 1)



% Normalize
if nor == 1
    A = A./(eigs(A,1)+1) - eye(size(A));
end

[V, D] = eig(A);
lambda = eig(A);

% convert to discrete lambda - comment out if system is already discrete
lambda = exp(lambda);
% get only the X% largest values
[modes, idx] = sort(lambda);
cutoff = round(numel(modes)*thresh);
transient_modes = modes(1:cutoff);% Get the eigenvalue with the smallest percentage to represent transient modes.
persistent_modes = modes((end-cutoff+1):end);% Get the eigenvalue with the largest percentage to represent the persistent modality.

% get controllability, original
% phi_p = sum((1 - (persistent_modes)).*(V(i,idx((numel(idx)-cutoff+1):end)).^2)');
% phi_t = sum((1 - (transient_modes)).*(V(i,idx(1:cutoff)).^2)');

% get controllability, looping across all regions
for i = 1:size(A,1)
    phi(i) = sum((1 - (modes)).*(V(i,idx).^2)');
    phi_p(i) = sum((1 - (persistent_modes)).*(V(i,idx((numel(idx)-cutoff+1):end)).^2)');
    phi_t(i) = sum((1 - (transient_modes)).*(V(i,idx(1:cutoff)).^2)');
end
end
