# Software

This will serve as a helpful guide to interacting with SCG software. We will
add libraries on demand. Please [open an issue](https://github.com/stanford-rc/docs-scg/issues)
to request information added on packages.

## Sequence Read Archive

To download data from the [Sequence Read Archive](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR2045608)
you can use the [sra-toolkit](https://github.com/ncbi/sra-tools) that is available to you on SCG. Here is how to download
the file linked above:


```bash
# load the sratoolkit module
ml sratoolkit

# get the zipped fast1 for the run
fastq-dump --split-files --gzip SRR2045608
```

Want to see other software packages added here? [let us know](https://github.com/stanford-rc/docs-scg/issues)
