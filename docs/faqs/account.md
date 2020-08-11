# Is `--account=...` required? 

All jobs ran on SCG get charged to an account, in some cases for real money and
in others just for tracking and thus require an `--account=` specification.
There are a number of ways to set this for jobs:

* `sbatch/srun/salloc` command line option: `--account=default|PISUNetID|ProjectID`
* In the job script: `#SBATCH --account=PISUNetID|ProjectID`
* Setting a default in your $HOME/.bashrc: `export SBATCH_ACCOUNT=default|PISUNetID|ProjectID`
    * Note: SBATCH_ACCOUNT Will be overridden by job script and command line values, if they are used.

For all partitions '''except''' interactive, use the **PISUNetID** or **ProjectID** to
which the job should be charged. For most people the only available option is a
single **PISUNetID** for the lab/group they are a member of, but those who work
across several lab or projects will need to keep closer track of the account to
be charged. 

For the interactive partition there is no charge for usage and so the `default`
account should be used. 

# I already submitted a bunch of jobs but put in the wrong account, how can I fix this?

Not a problem, simply run for each pending **JOBID**:

```
scontrol update jobid=JOBID account=default|PISUNetID|ProjectID
```

If your job has already entered the running state you will need to kill it
(`scancel JOBID`) and resubmit to change the account. 

# How do I know what accounts I can submit with?

A utility has been provided to list the details of your SCG cluster account, try `scgwhoami`, for example:
```
[griznog@smsx10srw-srcf-d15-37 ~]$ scgwhoami 
SCG Account Information
       Real Name: John Hanks
        username: griznog
       uidNumber: 325892
           $HOME: /home/griznog
   primary group: upg_griznog
       gidNumber: 3772
secondary groups: scg-admin,scg-users,scgpm-informatics_wu,scg_cluster_users,scg_lab_joewu,scg_cluster_admins,scg_cluster_apps,scg_prj_clinical_service,scg_prj_gbsc

Available SLURM Accounts
  clinical_service
  gbsc
  default
```


