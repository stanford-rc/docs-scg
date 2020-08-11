# **nodes** vs **tasks** vs **cpus** vs **cores** 

A combination of raw technical detail, Slurm's loose usage of the terms `core`
and `cpu` and multiple models of parallel computing require establishing a bit
of background to fully explain how to make efficient use of multiple cores on
SCG. Before we delve into that...

## TL;DR

For the impatient reader, in 99.9% of the cases SCG was designed to support, 

```
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=N
```

is the correct way to request N cores for a job. Just replace N in that config
with the number of cores you need and optionally inside job scripts use the
`${SLURM_CPUS_PER_TASK}` variable to pass the number of cores in the job to
commands that accept an argument for number of core, cpus or threads, e.g.,

```
mycommand -arg1 -arg2 --threads=${SLURM_CPUS_PER_TASK} ...
```

## Computer architecture

The parts of a modern computer we need to understand to apply to running jobs
are listed here. (Note: This is way oversimplified and intended to give a basic
overview for the purposes of understanding how to request resources from Slurm,
there are a lot of resources out there to dig deeper into computer
architecture.)

<dl>
  <dt>Board</dt>
    <dd>A physical motherboard which contains one or more of each of Socket, Memory bus and PCI bus.</dd>
  <dt>Socket</dt>
    <dd>A physical socket on a motherboard which accepts a physical CPU part.</dd>
  <dt>CPU</dt>
    <dd>A physical part that is plugged into a socket.</dd>
  <dt>Core</dt>
    <dd>A physical CPU core, one of many possible cores, that are part of a CPU.</dd>
  <dt>HyperThread</dt>
    <dd>A virtual CPU thread, associated with a specific Core. This can be enabled or disabled on a system. SCG typically disabled hyperthreading.</dd>
  <dt>Memory Bus</dt>
    <dd>A communication bus between system memory and a Socket/CPU.</dd>
  <dt>PCI Bus</dt>
    <dd>A communication bus between a Socket/CPU and I/O controllers (disks, networking, graphics,...) in the server.</dd>
</dl>

Slurm complicates this, however, by using the terms `core` and `cpu`
interchangeably depending on the context and Slurm command. `--cpus-per-taks=`
for example is actually specifying the number of cores per task. 

## Parallel Computing

A very simplified description of parallel computing which is sufficient for
most computing is to break parallel workloads into these three categories:

<dl>
  <dt>Fine grained</dt>
    <dd>Each process does a <b>lot</b> of communication with the other processes. Think of a model which uses a grid of cells, and at each iteration all the cells exchange information with their neighboring cells. These types of applications are typically limited by interprocess communication bandwidth.</dt>
  <dt>Coarse grained</dt>
    <dd>Each process occasionally comunicates with other processes. A model which has independent units that occasionally exchange information globally would fall into this category. These types of processes are typically CPU or I/O limited.</dt>
  <dt>Embarrassingly Parallel</dt>
    <dd>Processes do not communicate with each other and run completely independently, possibly including a step to merge results when the last process finishes. These types of processes are typically CPU or I/O limited.</dt>
</dl>

Many bioinformatics tasks fall into the last category. Alignment, for instance,
can be easily parallelized by breaking input sequences into subsets which are
then individualy aligned to a reference and the results merged/sorted after all
subsets are complete. Some tools do this internally, e.g. running BLAST with
some number of threads allows BLAST to place subsets of input sequence into
each thread and then align against a shared in-memory reference, thus giving a
pretty good speedup to the overall alignment task.

As the above example implies, when a task is broken up to be parallelized, the subtasks can be ran in more than one way. Models we care about for this are:

### MPI

MPI (Message Passing Interface) is not very common in bioinformatics tools as
it is (in the opinion of this sysadmin) difficult to debug and use correctly
and is overkill for breaking up embarassingly parallel tasks. It's so rare, in
fact, that SCG by default rejects jobs that request more than one node on the
assumption that doing so is almost always an error in the job submission. A
special hidden partition is available for running MPI jobs upon request.
MPI is really a special case of using Tasks (see below) to parallelze work
but it has a complicated enough wrapper to deserve its own category.

### Threads

Most bioinformatics tools that include a parallel option in the application use
threading, with the most commonly used implementation being OpenMP.
Applications with take an argument specifying cores, threads or CPUs are very
likely to be using this model to parallelize the work. Threads can make
efficient use of memory for things like holding reference data used by multiple
threads/processes while running. 

### Tasks

The most common example of parallelizing this way on SCG is to take a directory
with many different sequence files and use a job script or job array to run the
same command on all files, placing each command into its own job. This is what 
most bioinformatics workloads look like, at some point during a project when 
there are too many tasks or the tasks are too large to handle on a laptop or
workstation, they can easily be broken into jobs to run in parallel on the 
SCG cluster resources.




