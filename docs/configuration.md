# SGI Cluster Hardware Resources

### Intel Xeon Haswell Nodes
2U Dell [PowerEdge R730xd](https://www.dell.com/en-us/work/shop/povw/poweredge-r730xd)

* Dual Intel Xeon E5-2683 processors, 2.00GHz, 14-cores/28-threads
* 396GB DDR4-2133 Registered EEC memory
* 20 terabytes of flash memory
* 4 NVidia Pascal GPUs (P100s, especially suited to deep learning)
* 150+ terabytes of local scratch storage. 

The UV300 is available on the SCG cluster in the `nih_s10` partition. For more information about how to use it see:

* [Working with Slurm](tutorials/job_scripts.md)
* [Using GPUs](tutorials/gpus.md)

This supercomputer is made available to the Stanford community via the Genetics
Bioinformatics Service Center (GBSC).  For more background information about
the UV-300 and the GBSC, see the [GBSC
website](http://gbsc.stanford.edu/uv300.html).

## Configuration Details 
* High memory-to-processor ratio 
* Intel Xeon E7-8867 v4 with 24 CPUs/socket  
* SGI NUMALink™ 7 interconnect (NL7; 7.47GB/s bidirectional peak) 
* Ultra low latency: All-to-All & Multi-dimensional All-to-all network topology
* Extreme I/O: 12 PCIe Gen3 slots per chassis 
* NVidia Pascal GPUs 
    * 5.3 TFLOPS of double-precision floating point (FP64) performance 
    * 10.6 TFLOPS of single-precision floating point (FP32) performance 
    * 21.2 TFLOPS of half-precision floating point (FP16) performance
* NVIDIA’s NVLink: provides GPU-to-GPU data transfers at up to 160 Gigabytes/second of bidirectional bandwidth
* HBM2: offering three times (3x) the memory bandwidth of the Maxwell GM200 GPU 
* Unified Memory and Compute Preemption via CUDA 8+


