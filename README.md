# ALECM

# Driving brain state transitions via Adaptive Local Energy Control Model - MATLAB Code

This repository contains MATLAB code for calculating control energy of brain state transitions and controllability in brain networks. The code includes functions for computing control energy for binary brain states, Hetero-state transitions, and Homo-state maintenance, as well as for calculating  controllability metrics.

## Code Overview

### 1. **`binarystate_controlenergy`**

This function calculates the control energy for binary brain state transition

**Inputs**:

- Connectivity matrix (A) [normalized and standardized]

**Outputs**:

- Control energy for  binary brain state transitions.

### 2. **`Hetero_state_energy` / `Homo_state_energy`**

These functions calculate the control energy required for:

- Hetero-state transitions (changing between different brain states)
- Homo-state maintenance (maintaining a stable brain state)

**Inputs**:

- Adjacency matrix (A) [normalized and standardized]
- Initial state signal 
- Target state signal
- Start and end time for state signal selection

**Outputs**:

- `sum_energy`: Total energy for all brain regions at each time point.
- `aver_energy`: Average energy for each time point.

**note**:

- The demo code takes SZ subjects as an example.
- If you need to run other types of subjects, replace “SZ” with “type name”.

### 3. **`modal_controllability`**

This function computes modal controllability, persistent modal controllability, and instantaneous modal controllability for a given brain network.

**Inputs**:

- Connectivity matrix (A) [structural, not functional]
- Threshold value (e.g., 10%)
- Normalization option (1 for normalization, 0 for no normalization)

**Outputs**:

- `phi`: Modal controllability
- `phi_p`: Persistent modal controllability
- `phi_t`: Instantaneous modal controllability

### 4. **`Average_controllability`**

This function calculates the average controllability for a brain network.

**Inputs**:

- Adjacency matrix (A)

**Outputs**:

- `Values`: Average controllability values.

## Requirements

- MATLAB (R2017b or later recommended)
- No additional toolboxes required, but standard MATLAB functions are used.

## Installation

1. Clone or download the repository to your local machine.

2. Add the repository folder to your MATLAB path:

   ```
   matlab
   
   addpath('path_to_your_repository');
   ```

3. Ensure that the required input matrices (e.g., adjacency matrix) are available for the functions.

## Usage Example

### Example for `modal_controllability`:

```
matlab复制代码% Define the connectivity matrix A and other parameters
A = rand(100);  % Replace with your actual connectivity matrix
thresh = 0.1;   % Example threshold value
nor = 1;         % Use normalization

% Call the function to compute modal controllability
[phi, phi_p, phi_t] = modal_controllability(A, thresh, nor);
```

## Test Data

We provide test data in the `SC_cell.mat` file, which includes structural connectivity (SC) for HC, SZ, and BD patients and `BOLD_cell.mat` file , which includes BOLD signal data for HC, SZ, and BD patients. You can use this data as input to run the functions and test their functionality.

## Results

The results of the computations are saved in the `Hetero_state_energy.mat/Homo_state_energy.mat/binarystate_energy.mat` file, The results include energy calculations for different brain state transitions.

## Acknowledgments

- **Authored by**: Rong Yao (Taiyuan University of Technology)
- **Paper Title**: *Driving Brain State Transitions via Adaptive Local Energy Control Model*
