# Why use Slurm?

Within the SCG cluster, Slurm functions as a resource broker. Submitting a job
to Slurm requests a set of CPU and memory resources. Slurm orders these
requests and gives them a priority based on the cluster configuration and runs
each job on the most appropriate available resource in the order that respects
the job priority or, when possible, squeezes in short jobs via a backfill
scheduler to harvest unused cpu time. Using Slurm allows many users to fairly
share a set of computational resources with greatly reduced danger of
negatively impacting anotehr persons jobs or work while also allowing the
resources to be better and more fully utilized over time.

In addition to making it easier to effectively share a resource, Slurm also
acts as a powerful tool for managing workflows. By encapsulating steps in job
scripts it becomes possible to easily repeat and reuse workflows and having
such job scripts adds to the documentation of the associated process.

# What is a job script?

A job script is a normal unix [shell
script](https://en.wikipedia.org/wiki/Shell_script) which optionally contains
lines flagged such that the Slurm submission process can read arguments from
them. A simple _hello world_ job script using Bash would be

~~~
#!/bin/bash

# See `man sbatch` or https://slurm.schedmd.com/sbatch.html for descriptions
# of sbatch options.
#SBATCH --job-name=hello_world
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=interactive
#SBATCH --account=default
#SBATCH --time=1:00:00

echo 'Hello World!'
~~~

# Submitting a job

Saving the script as `hello_world.sh` and submitting it to Slurm with
[`sbatch`](https://slurm.schedmd.com/sbatch.html) results in the job running
and producing an output file. The default output file is
`slurm-JOB_ID.out` located in the directory from which the job was submitted.
For example:

~~~
[griznog@smsx10srw-srcf-d15-37 jobs]$ sbatch hello_world.sh 
Submitted batch job 6592914
[griznog@smsx10srw-srcf-d15-37 jobs]$ cat slurm-6592914.out
Hello World!
~~~

The [`sbatch` man page](https://slurm.schedmd.com/sbatch.html) lists all sbatch options. 

# Managing Slurm Jobs

## squeue

Once a job is submitted, it either immediately runs if resources are available
and there are no jobs ahead of it in the queue or it is queued and marked as
Pending. Pending and running jobs can be monitored with the 
[`squeue`](https://slurm.schedmd.com/squeue.html) command.

The default [`squeue`](https://slurm.schedmd.com/squeue.html) output shows all jobs:

~~~
[griznog@smsx10srw-srcf-d15-37 jobs]$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
           6564781 interacti     wrap   crolle PD       0:00      1 (Resources)
           6564782 interacti     wrap   crolle PD       0:00      1 (Priority)
           6564783 interacti     wrap   crolle PD       0:00      1 (Priority)
           6564784 interacti     wrap   crolle PD       0:00      1 (Priority)
           6564785 interacti     wrap   crolle PD       0:00      1 (Priority)
           6564786 interacti     wrap   crolle PD       0:00      1 (Priority)
           6564787 interacti     wrap   crolle PD       0:00      1 (Priority)
           6564788 interacti     wrap   crolle PD       0:00      1 (Priority)
           6564789 interacti     wrap   crolle PD       0:00      1 (Priority)
           6564790 interacti     wrap   crolle PD       0:00      1 (Priority)
           6564791 interacti     wrap   crolle PD       0:00      1 (Priority)
           6564792 interacti     wrap   crolle PD       0:00      1 (Priority)
           6592902       dtn seqctr_s     root PD       0:00      1 (BeginTime)
           6564793 interacti     wrap   crolle PD       0:00      1 (Priority)
           6564794 interacti     wrap   crolle PD       0:00      1 (Priority)
           6564795 interacti     wrap   crolle PD       0:00      1 (Priority)
...
~~~

Some useful [`squeue`](https://slurm.schedmd.com/squeue.html) commands are:

| Command                         | Description                                               |
| ------------------------------- | --------------------------------------------------------- |
| `squeue -u $USER`               | Show only jobs owned by $USER.                            |
| `squeue -t pd`                  | Show only pending jobs. `-t r` to show only running jobs' |
| `squeue -j JOBID`               | Show details for job JOBID.                               |
| `squeue -j JOBID --format="%m"` | Use `--format` to show only the memory requested.         |

## scancel

The simplest method of cancelling a running job or job array task is to use [`scancel`](https://slurm.schedmd.com/scancel.html). For example:

~~~
[griznog@smsx10srw-srcf-d15-37 jobs]$ squeue -u $USER
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
           6593409 interacti     wrap  griznog PD       0:00      1 (Priority)
[griznog@smsx10srw-srcf-d15-37 jobs]$ scancel 6593409
[griznog@smsx10srw-srcf-d15-37 jobs]$ squeue -u $USER
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
[griznog@smsx10srw-srcf-d15-37 jobs]$ 
~~~

The [`scancel` man page](https://slurm.schedmd.com/scancel.html) lists the
options to [`scancel`](https://slurm.schedmd.com/scancel.html), many of which
are useful for selecting subsets of jobs to operate on.
[`scancel`](https://slurm.schedmd.com/scancel.html) can also be used to send
specific [signals](https://en.wikipedia.org/wiki/Signal_(IPC)) to a jobs
processes. This can be useful for more advanced jobs which are designed to
perform different functions in response to receiving a signal, for instance,
applications that can perform a checkpoint might be triggered to do so manually
with a signal sent via [`scancel`](https://slurm.schedmd.com/scancel.html). 

## sinfo

The [`sinfo`](https://slurm.schedmd.com/sinfo.html) command can be used to list available partitions, show status and list node and partition configurations. To list partitions:

~~~
[griznog@smsx10srw-srcf-d15-37 jobs]$ sinfo
PARTITION   AVAIL  TIMELIMIT  NODES  STATE NODELIST
batch*         up 120-00:00:     22    mix dper730xd-srcf-d16-[01,03,05,07,09,11,13,15],dper7425-srcf-d15-13,sgisummit-frcf-111-[08,12,14,16,18,20,24,26,28,34,36,38],sgiuv20-rcf-111-32
batch*         up 120-00:00:      3  alloc sgisummit-frcf-111-[10,22,30]
batch*         up 120-00:00:     24   idle dper730xd-srcf-d16-[17,19,21,23,25,27,29,31,33,35,37,39],dper930-srcf-d15-05,dper7425-srcf-d15-[09,11,15,17,19,21,23,25,27,29,31]
interactive    up 120-00:00:      2 drain* hppsl230s-rcf-412-01-l,hppsl230s-rcf-412-02-l
interactive    up 120-00:00:      5    mix dper910-rcf-412-20,hppsl230s-rcf-412-01-r,hppsl230s-rcf-412-02-r,hppsl230s-rcf-412-03-l,hppsl230s-rcf-412-03-r
interactive    up 120-00:00:     18   idle hppsl230s-rcf-412-04-l,hppsl230s-rcf-412-04-r,hppsl230s-rcf-412-05-l,hppsl230s-rcf-412-05-r,hppsl230s-rcf-412-06-l,hppsl230s-rcf-412-06-r,hppsl230s-rcf-412-07-l,hppsl230s-rcf-412-07-r,hppsl230s-rcf-412-08-l,hppsl230s-rcf-412-08-r,hppsl230s-rcf-412-09-l,hppsl230s-rcf-412-09-r,hppsl230s-rcf-412-10-l,hppsl230s-rcf-412-10-r,hppsl230s-rcf-412-11-l,hppsl230s-rcf-412-11-r,hppsl230s-rcf-412-12-l,hppsl230s-rcf-412-12-r
nih_s10        up 4-00:00:00      1    mix sgiuv300-srcf-d10-01
nih_s10_gpu    up 4-00:00:00      1    mix sgiuv300-srcf-d10-01
dtn            up 120-00:00:      2   idle cfxs2600gz-rcf-114-[06,08]
apps           up 120-00:00:      1   idle dper7425-srcf-d10-37
~~~

## sacct

The [`sacct`](https://slurm.schedmd.com/sacct.html) command can be used to retrieve infomration about jobs that have completed. For example:

~~~
[griznog@smsx10srw-srcf-d15-37 jobs]$ sacct -j  6593409
       JobID    JobName  Partition    Account  AllocCPUS      State ExitCode 
------------ ---------- ---------- ---------- ---------- ---------- -------- 
6593409            wrap interacti+    default          1 CANCELLED+      0:0 
6593409.bat+      batch               default          1  CANCELLED     0:15 
6593409.ext+     extern               default          1  COMPLETED      0:0 
~~~

When troubleshooting jobs, the *ExitCode* can be useful to determine how the job ended as it shows the exit code of the job script and the signal which caused the process to terminate. For the example above, the job was cancelled and it's script was killed by signal 15 with the job script returning 0.

The [`sacct`](https://slurm.schedmd.com/sacct.html) command can return many details about jobs, consult the [`sacct` man page](https://slurm.schedmd.com/sacct.html) for more information about options and values that can be retrieved for jobs.

# More information

For more information about additional Slurm commands, see the [Slurm documentation](https://slurm.schedmd.com/documentation.html). 

