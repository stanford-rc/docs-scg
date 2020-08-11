# Accessing SCG
## SCG OnDemand

[SCG OnDemand](https://ondemand.scg.stanford.edu) is a web-based interface to
SCG cluster resources. OnDemand offers terminal, file manager and editor and
GUI access to an SCG desktop session and GUI applications right from a web
browser. 

## SSH (Terminal)

From the terminal application of your choice, ssh to `login.scg.stanford.edu`
with your SUNetID username and password,

~~~
ssh SUNetID@login.scg.stanford.edu
~~~

# Data Management

Data can be moved in and out of SCG with a number of tools/methods.

* [SCG OnDemand File App](https://ondemand.scg.stanford.edu/pun/sys/files/)
* [Globus](https://www.globus.org) (endpoint: SCG Cluster Storage)
* [Samba](smb://samba.scg.stanford.edu) 
* rsync
* scp/sftp

For more information see [Managing and Moving Data](tutorials/data_management.md).

# Software

## Environment Modules

SCG uses modules to manage software not installed into the base operating
system image. Basic usage is shown below:

| Command                              | Description                                        |
|------------------------------------- |----------------------------------------------------|
| `module avail`                       | List available software                            |
| `module load APP/VERSION`            | Load APP/VERSION into working environment          |
| `module unload APP/VERSION`          | Remove APP/VERSION from the working environment    |
| `module purge`                       | Remove all loaded modules from working environment |

# Slurm Job Submission

The SCG Cluster uses [Slurm](https://slurm.schedmd.com/) as it's job scheduler,
standard Slurm job scripts and commands will work, noting these SCG specific
requirements: 

* SCG partitions are `batch`, `interactive` and `nih_s10`.
* The `batch` and `nih_s10` partitions require specifying `--account=PI_SUNetID` where `PI_SUNetID` is the SUNetID of the PI for the job accounting. 
* A `--time=` time limit must be specified.
* SCG is limited to single node jobs, so most jobs will want `--nodes=1 --ntasks=1 --cpus-per-task=N` where `N` is the number of cores for a multithreaded application.

