# Is `--time=...` required?

Yes. Slurm uses the requested `--time=` for a job to determine if it is
eligible for backfill, that is, to see if there is an idle slot available which
may be reserved for a future job, but that future job starts far enough into
the future that the smaller job would be finished before then. Having an
accurate --time for a job gives it the best chance of running sooner than
normal as backfill and helps make the overall utilization of the cluster more
efficient.

Operationally, there are two ways to handle this:

 1. Set a default time if none is specified.
 1. Force `--time=` to be included on every job.

Since the sysadmins really have no idea what a good default time would be,
trying to set one can result in having jobs die before they finish, thus
wasting the time spent on them (in the absence of good checkpointing) or always
guessing long and making backfill less efficient. Because of this, SCG requires
that `--time=` be specified with every job.

It is understandable, however, that someone who has applications or workflows
which are inherently unpredictable would just want to have some default time
set for them and not worry about this. If that is desired, then adding to the
`~/.bashrc` file this line:

```
export SBATCH_TIMELIMIT=4-00:00:00
```

Would cause `sbatch` to always set `--time=4-00:00:00` unless it is explicitly set on the `sbatch` command line.
