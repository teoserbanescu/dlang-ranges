# dlang-ranges

This repository contains code used for benchmarking the behaviour of InputRanges and OpApply ranges in D.

There are more operations used to test the behaviour of the ranges:
* simple iteration
* filter
* map
* a composition of multiple operations

To generate benchmarks, run the script with the following command:
./benchmark \<operation\>

\<operation\> can be one of the following: iterate, filter, map, mapfilter

If you want to run the operations without using the script, use the file run_benchmaks.d.
Usage: ./run_benchmarks <operation> <number_of_runs>
