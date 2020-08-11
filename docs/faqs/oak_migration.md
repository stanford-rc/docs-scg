# SCG Storage migration from Isilon (OneFS) to Oak (Lustre) 

A number of details about SCG storage change with the migration from the Isilon OneFS storage to the Oak Lustre storage. The key points are:

* All ACLs in use on SCG are now POSIX ACLs. ACLs can be set/managed with the `setfacl` and `getfacl` commands.

* `df` now returns the space for the entire Oak filesystem rather than information for a lab or project specific quota. 

* Oak quotas for a given PISUNetID can be viewed with: 
 

    ````
    lfs quota -h -g scg_lab_PISUNetID /oak 
    ````

* The old Isilon OneFS storage is mounted read-only under `/deprecated/ifs` but is subject to removal with **NO ADVANCE NOTICE**. Every effort was made to ensure data was completely copied to Oak, but this will be temporarily available for comparing and retrieving any NFS4 ACLs from the old filesystem.

* With the move to Oak, inodes now matter. It's more important now to bundle large numbers of small files using `tar` or `zip` or similar utilities. In addition to quotas for space, labs are now subject to quotas for total number of files and either quota can be exhausted which will prevent writes to the storage unless/until quota is increased or other files/data are removed.






