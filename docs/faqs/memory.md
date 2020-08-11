# Thanks, for the memories...

In more traditional HPC it's usually possible to predict how much memory an
application will need for a given set of input data and parameters. However, in
bionformatics work the ability to accurately predict memory usage is rare. 

## Guess 1: Tool provided estimate

The first thing to do is check the tool documentation and any available forums
to see if there is already a heuristic for estimating memory use and use it.
This isn't always available, so if not then...

## Guess 2: How big is the input data?

A safe assumption is that the application will try to place all the data
(sequence, reference, ...) in memory.  Exceptions might be tools that convert
from one format to another which may, in fact stream the data and use very
little memory. But alignment, searching and assembly can be assumed to, if not
require enough memory to hold the entire data set, to at least run faster if
that memory is avaialble. 

It's usually safe to assume that a tool is storing bases as characters in
strings, which means you'll need at least 1 byte per base. This makes the math
easy. For example with 10 Gbases of data, 
```
10 Gbases == 10 GB
```
For safety sake, add an extra 4 GB to the data size based estimate 
and give it a try.

## Guess 3: What is the application?

If the data size based guess proves to be inadequate, then next consider what the tools is doing. 

* File Format conversion: Try doubling the estimate, maybe the data is buffered in and out so 2x data size is the next step.
* Alignment: A tool that uses multiple threads may need additional memory, try at least doubling the memory and possibly giving the app `(Gbases * #cores) + 4GB`. 
* Assembly: Assemblers can be all over the place. If the first estimate failed, then quadrupling memory is a good start. If the assembler uses a graph based algorithm then memory usage can really skyrocket.

## Guess 4: Feed me, Seymore...

If all else fails, double memory until it works. If the job is taking a really
long time to reach the out-of-memory failure, then consider running on the
UV300 and just giving it a monstrous amount of memory. If you have many similar
jobs to run, then doing this first and using `srun` in your job script to start
the task will prodcue some meomry use statistics in the job record which can
then be used to better tune subsequent runs. Howver, note again that assemblers
in particular can be all over the place on memory usage with even minor changes
in sensitivity and data so some tasks are just inherently unpredictable and
throwing buckets of memory at them is the most expeident method.

