# Special Access for COVID-19 Research

If your work is related to the COVID-19 virus, you can apply for Enhanced
Access to the SCG Cluster.  With this access, we will give your compute jobs on
the SCG Cluster a higher priority, which means they will execute sooner, wait
less, and run more often.

*This Enhanced Access will NOT prevent your jobs from waiting. It will only
ensure that they will be given priority in scheduling when resources are
available.*

Enhanced Access COVID-19 jobs will be considered for scheduling above all other
pending jobs, within the limits described at the bottom of this page.

## Requesting Access

To get Enhanced Access; please fill out [the application
form](https://bit.ly/GBSC-COVID-19) with your name, SUNetID, and SUNetID of
your lab's PI; and give us a short paragraph about how your work relates to
COVID-19 research and how better access to the cluster can help you achieve
your goals faster and more efficiently. This application will be sent to your
PI for their approval.

If you would like to add another lab member on to an existing authorization,
you do not need to fill in the survey again.  Instead, email
[scg-action@lists.stanford.edu](mailto:scg-action@lists.stanford.edu), CCing
your PI.  In the email, provide your SUNetID, the SUNetID of your lab's PI, and
the SUNetID of the person who should be added to the existing request.  Your PI
will need to approve the change (a simple reply-all to your email is fine).

## How to Use

Priority is provided for batch jobs using the `batch` and `nih_s10` partitions.
Your job should be able to run using the `sbatch` command, so you should start
by writing your batch script as normal.

High-priority access is being implemented using a SLURM QoS.  Once your batch
script is ready, you should modify it to use the new `covid19` QoS.  You can do
this one of two ways:

1. In your `sbatch` command line, add the option `-q covid19` (or `--qos=covid19`).

2. In the batch script, near the top, add the line `#SBATCH --qos=covid19`.
   If you use this method, the line must appear before any commands.

The first method applies the QoS to only that specific job submission.  The
second method applies the QoS to all job submissions using that batch script.

**REMEMBER:** This QoS may only be used for jobs related to COVID-19 research.
If you have a pipeline that is being used for COVID-19 *and* non-COVID-19
research, you should use method 1 (the `-q covid19` method) only for the
COVID-19 runs.

Once your job has been submitted, to confirm that your job is using the
`covid19` QOS, you can run this command:

~~~
scontrol show job JOBID
~~~

(Replace `JOBID` with your job's ID number.)  Look for the `QOS` entry (near
the top of the output) to confirm that you are using the `covid19` QoS.

If you already have a job submitted, and it is _not_ yet running, you can use the
following command to change the job to use the new `covid19` QoS:

~~~~
scontrol update jobid=JOBID9 QOS=covid19
~~~~

(Again, substitute your job's ID number.)

Note that the usual SLURM lag times still apply: Once a job is submitted (or
modified), it can take a minute or two before it is run.  When the cluster is
being fully-utilized, you job will still wait.

* If your job is waiting because of `(Resources)`, your job is waiting for
  other jobs to finish.  *COVID-19 jobs will not preempt/terminate non-COVID-19
  jobs.*  As soon as enough jobs complete to free up the necessary resources,
  your job will run.

* If your job is waiting for any `(QOS...)` reason, that means one or more of
  the below limits have been reached.  As other COVID-19 jobs complete, your
  job will begin.

## Current Limits

At this time (June 9 @ 15:00 US/Pacific), the following limits are in place:

* Each user may not have more than 5 jobs running under this QoS.

* Each group may not have more than 15 jobs running under this QoS.

* When adding up the number of CPU cores in use, no more than 180 may
  be in use by this QoS.

We will be monitoring the cluster and reserve the right to adjust limits (up
or down).  If we adjust limits down, we will not cancel any currently-running
jobs.
