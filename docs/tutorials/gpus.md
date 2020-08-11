## Available GPUs

GPUs are available in two locations:

* All login nodes are equipped with a small GPU to allow compiling and testing GPU applications.
* The UV300 has 4 x nVidia Tesla P100 GPUs.

## Requesting GPUs

Job requests for GPUs need to specify at least the following three Slurm options:

* An account with access to the `nih_s10` partition, usually one of: 
    * `--account=your_PI_SUNetID`
    * `--account=your_Project_ID`
* The `nih_s10` partition: 
    * `--partition=nih_s10`

* For N gpus `(1 <= N <= 4)`: 
    * `--gres=gpu:N`

## CUDA

There are several versions of CUDA available to use, for a complete list run:

* `module avail cuda`

There are also several CUDA enabled python virtual environments, to see a list run:

* `module load anaconda; conda env list | grep cuda`


